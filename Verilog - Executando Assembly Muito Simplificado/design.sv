`timescale 1ns/1ns

// Links uteis
/*
https://hexed.it/
https://circuitcove.com/system-tasks-file-read/
https://www.chipverify.com/verilog/verilog-case-statement
https://www.chipverify.com/verilog/verilog-arrays-memories
https://www.chipverify.com/systemverilog/systemverilog-file-io
*/

module MonitorTB;
  int fd, code, r;
  logic [7:0] mem [0:255]; // Define memory array to store the data
  int start = 0; // Start index
  int count = 6; // Maximum memory index to read

  initial begin
    fd = $fopen("output", "r");
    if (fd == 0) begin
      $display("Error: Could not open file.");
      $finish;
    end

    // Read data from the file into memory array
    code = $fread(mem, fd, start, count);
    if (code == 0) begin
      $display("Error: Could not read data.");
    end else begin
      $display("Read %0d bytes of data.", code);
    end
    
    // Display the contents of the first few memory locations
    for (int i = 0; i < 6; i++) begin
      $display("mem[%0d] = %b", i, mem[i]);
    end
    
    $display("========================================");
    
    // Display the contents of the first few memory locations
    for (int i = 0; i < 6; i++) begin
      $display("mem[%0d] = %b", i, mem[i]);
      
      case ( mem[i] )
        0 :
          begin
            r = mem[ i + 1 ] + mem[ i + 2 ];
            $display("ADD %0d + %0d = %0d", mem[ i + 1 ], mem[ i + 2], r);
            i += 2;
          end
        1:
          begin
            r = mem[ i + 1 ] - mem[ i + 2 ];
            $display("SUB %0d - %0d = %0d", mem[ i + 1 ], mem[ i + 2], r);
            i += 2;
          end
        /*case_item2,
        case_item3 : 	<single statement>
        case_item4 : 	begin
                            <multiple statements>
                            end
        default 	 : <statement>
          */
   	  endcase
    end
    
    $fclose(fd);
  end
endmodule
