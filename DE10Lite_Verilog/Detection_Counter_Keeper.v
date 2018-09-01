/*
By Artur Lach
Logic to keep the counter of detections
*/

module detection_counter_keeper #(parameter STARTING_COUNT = 32'd0)(in_reset, in_count_increment,
displ0, displ1, displ2, displ3, displ4, displ5);


input in_reset, in_count_increment; 
output wire [7:0] displ0, displ1, displ2, displ3, displ4, displ5;

reg [3:0] dig1, dig2, dig3, dig4, dig5, dig6;

reg [31:0] counter;

always@(posedge in_count_increment or posedge in_reset) begin
    if (in_reset) begin
        counter <= STARTING_COUNT;
    end
    else begin
        counter <= ((counter + 32'd1) > 32'd999999) ? 32'd1 : counter + 32'd1;
    end
end


always@(counter) begin
    dig6 = counter / 32'd100000;
    dig5 = (counter % 32'd100000) / 32'd10000;
    dig4 = (counter % 32'd10000) / 32'd1000;
    dig3 = (counter % 32'd1000) / 32'd100;
    dig2 = (counter % 32'd100) / 32'd10;
    dig1 = (counter % 32'd10) / 32'd1;
end

digit_display d1(.number(dig1), .seven_segment(displ0));
digit_display d2(.number(dig2), .seven_segment(displ1));
digit_display d3(.number(dig3), .seven_segment(displ2));
digit_display d4(.number(dig4), .seven_segment(displ3));
digit_display d5(.number(dig5), .seven_segment(displ4));
digit_display d6(.number(dig6), .seven_segment(displ5));


endmodule    