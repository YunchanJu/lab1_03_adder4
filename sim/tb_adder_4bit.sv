`timescale 1ns/1ps

module tb_adder_4bit;

    reg [3:0] a;
    reg [3:0] b;

    wire [3:0] s;
    wire       cout;

    adder_4bit dut(
        .a(a),
        .b(b),
        .s(s),
        .cout(cout)
    );

    integer i, j;
    integer checked = 0;

    reg [4:0] expected;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_adder_4bit);

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin

                a = i;
                b = j;

                expected = i + j;

                #10;

                if ({cout, s} !== expected)
                    $fatal(1,
                        "FAIL adder_4bit a=%0d b=%0d expected=%0d actual=%0d",
                        a, b, expected, {cout, s});

                checked = checked + 1;
            end
        end

        if (checked != 256)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS adder_4bit cases=%0d", checked);

        $finish;
    end

    initial begin
        #3000;
        $fatal(1, "Watchdog");
    end

endmodule