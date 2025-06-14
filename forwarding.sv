module forwarding(regWriteEx, regWriteMem, RegRdEx, RegRdMem, RegRn_ID, RegRm_ID, forwardA, forwardB, flagForward, SetFlag_ID, Branch, BRegFwd, RegWrite_WB, RegRd_WB, RegRd_ID, 
                RegRd_IF, BReg, CBZFwd, branch0, BLFwd, Uncondbranch_MEM, Uncondbranch_WB, MemWrite_ID, MemWrite_EX, MemWrite_MEM);
    input logic regWriteEx, regWriteMem, RegWrite_WB, SetFlag_ID, Branch, BReg, branch0, Uncondbranch_MEM, Uncondbranch_WB, MemWrite_ID, MemWrite_EX, MemWrite_MEM;
    input logic [4:0] RegRn_ID, RegRm_ID, RegRdEx, RegRdMem, RegRd_WB, RegRd_ID, RegRd_IF;
    output logic [1:0] forwardA, forwardB, BRegFwd, CBZFwd;
    output logic flagForward, BLFwd;
    logic [1:0]test;

    always_comb begin
        forwardA = 2'b00;
        forwardB = 2'b00;
        BRegFwd = 2'b00;
        flagForward = 1'b0;
        test = 0;
        BLFwd = 0;

        // ForwardA logic
        if (regWriteEx && (RegRdEx != 5'd31) && (RegRdEx == RegRn_ID)) begin
            test = 1;
                forwardA = 2'b10;
                if (RegRdEx == 5'd30) begin
                    BRegFwd = 2'b10; //forward from EX
                end
        end

        else if (regWriteMem && (RegRdMem != 5'd31) && (RegRdMem == RegRn_ID)) begin
            test = 2;
                forwardA = 2'b01;
                if (RegRdMem == 5'd30)
                    BRegFwd = 2'b01; //forward from MEM
        end

        else if (RegWrite_WB && (RegRd_WB != 5'd31) && (RegRd_WB == RegRn_ID)) begin
            test = 3;
                forwardA = 2'b11; //forward from WB
                if (RegRd_WB == 5'd30)
                    BRegFwd = 2'b11;
        end
        //forwardB
        if (regWriteEx && (RegRdEx != 5'd31) && (RegRdEx == RegRm_ID)) begin
            test = 1;
                forwardB = 2'b10;
                if (RegRdEx == 5'd30) begin
                    BRegFwd = 2'b10;
                end
        end

        else if (regWriteMem && (RegRdMem != 5'd31) && (RegRdMem == RegRm_ID)) begin
            test = 2;
                forwardB = 2'b01;
                if (RegRdMem == 5'd30)
                    BRegFwd = 2'b01;
        end

        else if (RegWrite_WB && (RegRd_WB != 5'd31) && (RegRd_WB == RegRm_ID)) begin
            test = 3;
                forwardB = 2'b11;
                if (RegRd_WB == 5'd30)
                    BRegFwd = 2'b11;
        end

        if (SetFlag_ID &&
            Branch) begin
                flagForward = 1'b1;
        end
        if ((RegRd_IF == 5'd30) && BReg && (RegRd_IF == RegRd_ID))// && MemWrite_ID)
            BRegFwd = 2'b10;
        else if ((RegRd_IF == 5'd30) && BReg && (RegRd_IF == RegRdEx))// && MemWrite_EX)
            BRegFwd = 2'b01;
        else if ((RegRd_IF == 5'd30) && BReg && (RegRd_IF == RegRdMem))// && MemWrite_MEM)
            BRegFwd = 2'b11;

        if (branch0 && (RegRd_IF == RegRd_ID))
            CBZFwd = 2'b10;
        else if (branch0 && (RegRd_IF == RegRdEx))
            CBZFwd = 2'b01;
        else if (branch0 && (RegRd_IF == RegRdMem))
            CBZFwd = 2'b11;

        if (branch0 && (RegRd_IF == RegRd_ID))
            CBZFwd = 2'b10;
        else if (branch0 && (RegRd_IF == RegRdEx))
            CBZFwd = 2'b01;
        else if (branch0 && (RegRd_IF == RegRdMem))
            CBZFwd = 2'b11;
        
        if (Uncondbranch_MEM && regWriteMem && (RegRn_ID == 5'd30)) begin
            BLFwd = 1;
            forwardA = 2'b01;
        end

        else if (Uncondbranch_WB && RegWrite_WB && (RegRn_ID == 5'd30)) begin
            BLFwd = 1;
            forwardA = 2'b11;
        end

        if (Uncondbranch_MEM && regWriteMem && (RegRm_ID == 5'd30)) begin
            BLFwd = 1;
            forwardB = 2'b01;
        end

        else if (Uncondbranch_WB && RegWrite_WB && (RegRm_ID == 5'd30)) begin
            BLFwd = 1;
            forwardB = 2'b11;
        end
            

    end


endmodule