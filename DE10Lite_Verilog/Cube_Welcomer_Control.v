/*
By Artur Lach
Main control logic for cube welcomer project.
Logic detects when person is detected in front of the device and controls speaker and
smiley circuit board outputs
*/


module cube_welcomer_control (in_clock, in_presence_signal,
in_reset, out_counter, out_smiley, out_speaker, debug_led, debug_led1, debug_led2);

input in_clock;
input in_presence_signal, in_reset;
output reg out_smiley, out_speaker;
output reg out_counter;
reg [31:0] clock_tick_counter1;
reg [31:0] clock_tick_counter2;
reg [31:0] debounce_counter;
reg smiley_completed_signal;
reg speaker_completed_signal;
reg user_detected;
output reg debug_led, debug_led1, debug_led2;


wire timeout1 = (clock_tick_counter1 == 1'd0); 
wire timeout2 = (clock_tick_counter2 == 1'd0);
wire triggers_completed = (smiley_completed_signal && speaker_completed_signal);
wire debounce_timeout = (debounce_counter == 1'd0);

// ON OFF Constants
parameter ON = 1'b1, OFF = 1'b0;

// Specify 1 and 5 seconds parameters
parameter ZERO = 32'd0;
parameter ONE_SEC = 32'd50000000;
parameter FIVE_SEC = 32'd250000000;
parameter DEBOUNCE_CYCLES = 32'd10000000;

// State machine
reg [1:0] state;

// States parameters
parameter USER_NOT_DETECTED = 2'b00;
parameter USER_DETECTED_NOT_WELCOMED = 2'b01;
parameter USER_DETECTED_AND_WELCOMED = 2'b10; 


always@(posedge in_clock or posedge in_reset) begin
    if (in_reset) begin
        state <= USER_NOT_DETECTED;
		  out_speaker <= OFF;
		  out_smiley <= OFF;
		  debug_led <= ON;
		  debug_led1 <= OFF;
		  debug_led2  <= OFF;
		  out_counter <= OFF;
		  clock_tick_counter1 <= ZERO;
		  clock_tick_counter2 <= ZERO;
		  smiley_completed_signal <= OFF;
		  speaker_completed_signal <= OFF;
		  debounce_counter <= ZERO;		  
    end
	 else begin
	 if (clock_tick_counter1 != ZERO) clock_tick_counter1 <= clock_tick_counter1 - 32'd1;
	 if (clock_tick_counter2 != ZERO) clock_tick_counter2 <= clock_tick_counter2 - 32'd1;
    case (state)
    USER_NOT_DETECTED: begin
			if (in_presence_signal && debounce_timeout) begin
				state <= USER_DETECTED_NOT_WELCOMED;
				clock_tick_counter1 <= ONE_SEC;
				clock_tick_counter2 <= FIVE_SEC;
				smiley_completed_signal <= OFF;
				speaker_completed_signal <= OFF;
			end
			else begin
				out_speaker <= OFF;
				out_smiley <= OFF;
				out_counter <= OFF;
				debug_led <= ON;
				debug_led1 <= OFF;
				debug_led2  <= OFF;
				smiley_completed_signal <= OFF;
				speaker_completed_signal <= OFF;
				clock_tick_counter1 <= ZERO;
				clock_tick_counter2 <= ZERO; 
				if (debounce_counter != ZERO) debounce_counter <= debounce_counter - 32'd1;
			end	
    end
    USER_DETECTED_NOT_WELCOMED: begin
			debug_led <= OFF;
			debug_led1 <= ON;
			debug_led2 <= OFF;
			out_counter <= ON;
			if (timeout1) begin
				out_speaker <= OFF;
				speaker_completed_signal <= ON;
			end
			else begin
				out_speaker <= ON;
				speaker_completed_signal <= OFF;
			end
			if (timeout2) begin
				out_smiley <= OFF;
				smiley_completed_signal <= ON;
			end
			else begin
				out_smiley <= ON;
				smiley_completed_signal <= OFF;
			end
			if (triggers_completed) begin
				state  <= USER_DETECTED_AND_WELCOMED;
				speaker_completed_signal <= OFF;
				smiley_completed_signal <= OFF;
			end				
    end
	 USER_DETECTED_AND_WELCOMED: begin
			debug_led <= OFF;
			debug_led1 <= ON;
			debug_led2 <= ON;
			out_counter <= OFF;
		if (!in_presence_signal) begin
			state <= USER_NOT_DETECTED;
			debounce_counter <= DEBOUNCE_CYCLES;
		end			
    end
    endcase
	 end
end

endmodule


