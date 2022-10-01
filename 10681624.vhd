
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    Port ( 
        i_clk : in std_logic;
        i_rst : in std_logic;
        i_start : in std_logic;
        i_data : in std_logic_vector(7 downto 0);
        o_address : out std_logic_vector(15 downto 0);
        o_done : out std_logic;
        o_en : out std_logic;
        o_we : out std_logic;
        o_data : out std_logic_vector (7 downto 0)
);
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
component Datapath is
    Port ( i_clk : in STD_LOGIC;
           i_rst : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (7 downto 0);
           o_data : out STD_LOGIC_VECTOR (7 downto 0);
           r0_load : in STD_LOGIC;
           r2_load : in STD_LOGIC;
           r3_load : in STD_LOGIC;
           r4_load : in STD_LOGIC;
           r0_res : in STD_LOGIC;
           r0_sel : in STD_LOGIC;
           r1_load : in STD_LOGIC;
           r2_sel : in STD_LOGIC;
           r3_sel : in STD_LOGIC;
           r4_sel : in STD_LOGIC;
           input_addr_load: in STD_LOGIC;
           input_addr_sel: in STD_LOGIC;
           output_addr_load: in STD_LOGIC;
           output_addr_sel: in STD_LOGIC;
           output_addr: out STD_LOGIC_VECTOR (15 downto 0);
           input_addr: out STD_LOGIC_VECTOR (15 downto 0);
           bit_sel: in STD_LOGIC_VECTOR (2 downto 0);
           o_end : out STD_LOGIC);
end component;
signal r0_load : STD_LOGIC;
signal r2_load : STD_LOGIC;
signal r3_load : STD_LOGIC;
signal r4_load : STD_LOGIC;
signal r0_res :  STD_LOGIC;
signal r0_sel : STD_LOGIC;
signal r1_load : STD_LOGIC;
signal r2_sel : STD_LOGIC;
signal r3_sel : STD_LOGIC;
signal r4_sel : STD_LOGIC;
signal input_addr_load: STD_LOGIC;
signal input_addr_sel: STD_LOGIC;
signal output_addr_load: STD_LOGIC;
signal output_addr_sel: STD_LOGIC;
signal output_addr: STD_LOGIC_VECTOR (15 downto 0);
signal input_addr: STD_LOGIC_VECTOR (15 downto 0);
signal bit_sel: STD_LOGIC_VECTOR (2 downto 0);
signal o_end : STD_LOGIC;

type S is (S0,S1,S2,S3,S4,S5,S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);

signal cur_state, next_state : S;

begin
    DATAPATH0: datapath port map(
       i_clk,
       i_rst,
       i_data,
       o_data,
       r0_load,
       r2_load,
       r3_load,
       r4_load,
       r0_res,
       r0_sel,
       r1_load,
       r2_sel,
       r3_sel,
       r4_sel,
       input_addr_load,
       input_addr_sel,
       output_addr_load,
       output_addr_sel,
       output_addr,
       input_addr,
       bit_sel,
       o_end
    );
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif i_clk'event and i_clk = '1' then
            cur_state <= next_state;
        end if;
    end process;
    
    process(cur_state, i_start, o_end)
    begin
        next_state <= cur_state;
        case cur_state is
            when S0 =>
                if i_start = '1' then
                    next_state <= S1;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S4;  
            when S4 =>
                if o_end = '1' then
                next_state <= S3;
                else
                    next_state <= S5;
                end if;
            when S3 =>
                next_state <= S0;  
            when S5 =>
                next_state <= S6;
            when S6 =>
                next_state <= S7;
            when S7 =>
                next_state <= S8;
            when S8 =>
                next_state <= S9;
            when S9 =>
                next_state <= S10;
            when S10 =>
                next_state <= S11;
            when S11 =>
                next_state <= S12;
            when S12 =>
                next_state <= S13;
            when S13 =>
                next_state <= S14;
            when S14 =>
                next_state <= S15;
            when S15 =>
                next_state <= S16;
            when S16 =>
                if o_end = '1' then
                    next_state <= S3;
                else
                    next_state <= S4;
                end if;
        end case;
    end process;
    
    process(cur_state)
    begin
        r1_load <= '0';
        r0_load <= '0';
        r2_load <= '0';
        r3_load <= '0';
        r4_load <= '0';
        output_addr_load <= '0';
        input_addr_load <= '0';
        bit_sel <= "000";
        o_address <= "0000000000000000";
        r0_res <= '0';
        r0_sel <= '0';
        r2_sel <= '0';
        r3_sel <= '0';
        r4_sel <= '0';
        output_addr_sel <= '0';
        input_addr_sel <= '0';
        o_en <= '0';
        o_we <= '0';
        o_done <= '0';
        
        case cur_state is
            when S0 =>
            when S1 =>
                output_addr_sel <= '1';
                output_addr_load <= '1';
                input_addr_sel <= '1';
                input_addr_load <= '1';
                o_address <= "0000000000000000";
                o_en <= '1';
                o_we <= '0';
            when S2 =>
                r0_load <= '1';
                r2_sel <= '1';
                r2_load <= '1';
                r3_sel <= '1';
                r3_load <= '1';
            when S3 =>
                o_done <= '1';
                r0_res <= '1';
                r0_load <= '1';
            when S4 =>
                o_address <= input_addr;
                o_en <= '1';
                o_we <= '0';
                r4_sel <= '1';
                r4_load <= '1';
            when S5 =>
                r1_load <= '1';
                input_addr_load <= '1';
            when S6 =>
                bit_sel <= "000";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
            when S7 =>
                bit_sel <= "001";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
            when S8 =>
                bit_sel <= "010";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
           when S9 =>
                bit_sel <= "011";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
            when S10 =>
                o_address <= output_addr;
                o_en <= '1';
                o_we <= '1';
            when S11 =>
                r4_sel <= '1';
                r4_load <= '1';
                output_addr_load <= '1';
            when S12 =>
                bit_sel <= "100";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
            when S13 =>
                bit_sel <= "101";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
            when S14 =>
                bit_sel <= "110";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
            when S15 =>
                bit_sel <= "111";
                r2_load <= '1';
                r3_load <= '1';
                r4_load <= '1';
                r0_sel <= '1';
                r0_load <= '1';
            when S16 =>   
                o_address <= output_addr;
                o_en <= '1';
                o_we <= '1'; 
                output_addr_load <= '1';
        end case;
    end process;
    
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
    Port ( i_clk : in STD_LOGIC;
           i_rst : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (7 downto 0);
           o_data : out STD_LOGIC_VECTOR (7 downto 0);
           r0_load : in STD_LOGIC;
           r1_load : in STD_LOGIC;
           r2_load : in STD_LOGIC;
           r3_load : in STD_LOGIC;
           r4_load : in STD_LOGIC;
           r0_res : in STD_LOGIC;
           r0_sel : in STD_LOGIC;
           r2_sel : in STD_LOGIC;
           r3_sel : in STD_LOGIC;
           r4_sel : in STD_LOGIC;
           input_addr_load: in STD_LOGIC;
           input_addr_sel: in STD_LOGIC;
           output_addr_load: in STD_LOGIC;
           output_addr_sel: in STD_LOGIC;
           output_addr: out STD_LOGIC_VECTOR (15 downto 0);
           input_addr: out STD_LOGIC_VECTOR (15 downto 0);
           bit_sel: in STD_LOGIC_VECTOR (2 downto 0);
           o_end : out STD_LOGIC);
end datapath;

architecture Behavioral of datapath is

signal o_reg0 : STD_LOGIC_VECTOR (7 downto 0);
signal o_reg1 : STD_LOGIC_VECTOR (7 downto 0);
signal o_reg2 : STD_LOGIC;
signal o_reg3 : STD_LOGIC;
signal o_reg4 : STD_LOGIC_VECTOR(7 downto 0);
signal res_reg0 : STD_LOGIC_VECTOR(7 downto 0);
signal mux_reg0 : STD_LOGIC_VECTOR(7 downto 0);
signal mux_bit : STD_LOGIC;
signal mux_reg2 : STD_LOGIC;
signal mux_reg3 : STD_LOGIC;
signal mux_reg4 : STD_LOGIC_VECTOR(7 downto 0);
signal p1 : STD_LOGIC;
signal p2 : STD_LOGIC;
signal sub : STD_LOGIC_VECTOR(7 downto 0);
signal sum : STD_LOGIC_VECTOR(7 downto 0);

signal mux_output_addr: STD_LOGIC_VECTOR(15 downto 0);
signal o_output_addr : STD_LOGIC_VECTOR(15 downto 0);
signal sum_output_addr : STD_LOGIC_VECTOR(15 downto 0);

signal mux_input_addr: STD_LOGIC_VECTOR(15 downto 0);
signal o_input_addr : STD_LOGIC_VECTOR(15 downto 0);
signal sum_input_addr : STD_LOGIC_VECTOR(15 downto 0);

begin

    with r0_sel select
        mux_reg0 <= i_data when '0',
                    sub when '1',
                    "XXXXXXXX" when others;
    
    with r0_res select
        res_reg0 <= mux_reg0 when '0',
                    "UUUUUUUU" when '1',
                    "XXXXXXXX" when others;

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_reg0 <= "UUUUUUUU";
        elsif i_clk'event and i_clk = '1' then
            if(r0_load = '1') then
                o_reg0 <= res_reg0;
            end if;
        end if;
    end process;
    
    sub <= o_reg0 - "00000001";
    
    o_end <= '1' when (o_reg0 = "00000000") else '0';
         
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg1 <= "00000000";
            elsif i_clk'event and i_clk = '1' then
                if(r1_load = '1') then
                    o_reg1 <= i_data;
                end if;
            end if;
        end process;
    
    with bit_sel select
        mux_bit <= o_reg1(7) when "000",
                   o_reg1(6) when "001",
                   o_reg1(5) when "010",
                   o_reg1(4) when "011",
                   o_reg1(3) when "100",
                   o_reg1(2) when "101",
                   o_reg1(1) when "110",
                   o_reg1(0) when "111",
                    'X' when others;
                    
    with r2_sel select
       mux_reg2 <= mux_bit when '0',
                   '0' when '1',
                   'X' when others;
                    
   process(i_clk, i_rst)
   begin
       if(i_rst = '1') then
           o_reg2 <= '0';
       elsif i_clk'event and i_clk = '1' then
           if(r2_load = '1') then
              o_reg2 <= mux_reg2;
           end if;
       end if;
   end process;

   with r3_sel select
       mux_reg3 <= o_reg2 when '0',
                   '0' when '1',
                   'X' when others;
                    
   process(i_clk, i_rst)
   begin
       if(i_rst = '1') then
           o_reg3 <= '0';
       elsif i_clk'event and i_clk = '1' then
           if(r3_load = '1') then
              o_reg3 <= mux_reg3;
           end if;
       end if;
   end process;       
      
    p1 <= o_reg3 xor mux_bit;
    p2 <= o_reg2 xor o_reg3 xor mux_bit;
        
    sum <= ("000000" & p1&p2) + (o_reg4(5 downto 0) & "00");
         
    with r4_sel select
        mux_reg4 <= "00000000" when '1',
                sum when '0',
                "XXXXXXXX" when others;
                
   process(i_clk, i_rst)
   begin
       if(i_rst = '1') then
           o_reg4 <= "00000000";
       elsif i_clk'event and i_clk = '1' then
           if(r4_load = '1') then
              o_reg4 <= mux_reg4;
           end if;
       end if;
   end process; 
                
    o_data <= o_reg4;         
                
    with output_addr_sel select
        mux_output_addr <= sum_output_addr when '0',
                    "0000001111101000" when '1',
                    "XXXXXXXXXXXXXXXX" when others;

    sum_output_addr <= "0000000000000001" + o_output_addr;

    process(i_clk, i_rst)
       begin
           if(i_rst = '1') then
               o_output_addr <= "0000000000000000";
           elsif i_clk'event and i_clk = '1' then
               if(output_addr_load = '1') then
                  o_output_addr <= mux_output_addr;
               end if;
           end if;
       end process;
                    
       output_addr <= o_output_addr;                    
                           
       with input_addr_sel select
          mux_input_addr <= sum_input_addr when '0',
                       "0000000000000001" when '1',
                       "XXXXXXXXXXXXXXXX" when others;
   
       sum_input_addr <= "0000000000000001" + o_input_addr;
   
       process(i_clk, i_rst)
          begin
              if(i_rst = '1') then
                  o_input_addr <= "0000000000000000";
              elsif i_clk'event and i_clk = '1' then
                  if(input_addr_load = '1') then
                     o_input_addr <= mux_input_addr;
                  end if;
              end if;
          end process;
       
       input_addr <= o_input_addr;
           
end Behavioral;
