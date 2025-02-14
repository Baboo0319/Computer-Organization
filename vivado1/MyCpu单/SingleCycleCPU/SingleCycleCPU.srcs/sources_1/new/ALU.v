module ALU(
    // ����ALUģ������������˿�
    input [31:0] ReadData1,      // ��һ�������������ԼĴ����ļ�
    input [31:0] ReadData2,      // �ڶ��������������ԼĴ����ļ�
    input [31:0] Ext,            // ��չ���������������ĳЩָ�
    input [4:0] Sa,              // ��λ����ͨ����shamt�ֶ��ṩ��
    input [2:0] ALUop,           // ָ��Ҫִ�еĲ�������
    input ALUSrcA,               // �����źţ�ѡ��InA����Դ��ReadData1��Sa��
    input ALUSrcB,               // �����źţ�ѡ��InB����Դ��ReadData2��Ext��

    output  zero,            // ����źţ���ResultΪ0ʱ��1
    output reg [31:0] Result,     // ���������
    output sign                  //blez
);

    // �ڲ������ߣ����ڱ�ʾʵ�ʲ�������Ĳ�����
    wire [31:0] InA;             // ʵ�ʲ�������ĵ�һ��������
    wire [31:0] InB;             // ʵ�ʲ�������ĵڶ���������

    // ���ݿ����ź�ALUSrcAѡ��InA����Դ��
    // ���ALUSrcAΪ1����InA = {27'b0, Sa}������27λΪ0����5λΪSa��
    // ����InA = ReadData1
    assign InA = ALUSrcA ? {{27{1'b0}}, Sa} : ReadData1;

    // ���ݿ����ź�ALUSrcBѡ��InB����Դ��
    // ���ALUSrcBΪ1����InB = Ext����չ�����������
    // ����InB = ReadData2
    assign InB = ALUSrcB ? Ext : ReadData2;

    // �������־λzero�����ResultΪȫ0����zero��1������Ϊ0
    assign zero = (Result == 32'b0) ? 1 : 0;
    
    assign sign=($signed(Result) <= 0) ? 1:0;
    // ����߼��飬���κ����뷢���仯ʱ�Զ����¼���Result
    always @(*) begin
        case(ALUop) // ����ALUop��ֵѡ��ִ�в�ͬ�����㹦��
            3'b000 : 
                Result = InA + InB;                    // �ӷ�����
            3'b001:
                Result = InA - InB;                    // ��������
            3'b010:
                Result = InB << InA[4:0];              // �����߼�������ʹ��Sa�ĵ�5λ��Ϊ��λ������
            3'b011:
                Result = InA | InB;                    // ������
            3'b100:
                Result = InA & InB;                    // ������
            3'b101:
                Result = (InA < InB) ? 32'b1 : 32'b0; // �޷���С�ڱȽϣ�����32λ��1��0��
            3'b110: 
                Result = (((InA < InB) && (InA[31] == InB[31])) || 
                          ((InA[31] == 1'b1) && (InB[31] == 1'b0))) ? 32'b1 : 32'b0; // ������С�ڱȽ�
            3'b111:
                Result = InA ^ InB;                    // �������
            default:
                Result = 32'h00000000;                 // Ĭ���������Result����
        endcase
    end

endmodule