library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fsm is   
    port(
        trasn_out : in std_logic;
        reset     : in std_logic;
        clock     : in bit;
        IHc       : in std_logic;
        DHc       : in std_logic;
        cadd      : in std_logic_vector(31 downto 0);
        ins       : in std_logic_vector(31 downto 0);
        pcc       : out std_logic_vector(1 downto 0 );
        ccm       : out std_logic;
        stateCPU  : out std_logic;
        IWrite    : out std_logic;
        IRWrite   : out std_logic;
        madd      : out std_logic_vector(31 downto 0);
        stateTrans: out std_logic_vector(2 downto 0);
        opType    : out std_logic_vector(1 downto 0);
        cacheType : out  std_logic;
        MemWrite  :out   std_logic;                                
        MemRead   :out    std_logic   
    );
end entity;

Architecture behav of fsm is 
    
    type state_type is ( s0,s1,s2a, s2b, s2c, s2d, s2e, s2f, s2g, s2h
                        ,s3,s4,s5,s6,s7,s8a, s8b, s8c, s8d, s8e, s8f, s8g, s8h
                        ,s9 );
    signal state: state_type;
    
    begin
    
        process( clock, reset, trasn_out, IHc, DHc, ins, cadd, state )
            
            variable opCode: std_logic_vector(5 downto 0);
        
            begin 
        
                if( reset='1') then 
                    state <= s0;
                end if;
                
                case state is 
                when s0 => IWrite <= '1'; opType <= "11";
                when s1 =>  cacheType <= '0';IWrite <= '0';
                            opType <= "00";
                            pcc <= "01";
                when s2a => madd(31 downto 5) <= cadd(31 downto 5);
                            madd(4 downto 0) <= "00000";
                            cacheType  <= '0';
                            opType <= "10";
                            stateTrans <= "000";
                            MemRead<='1';
                            pcc <= "10";
                            ccm <= '0';
                when s2b => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00001";
                                cacheType  <= '0';
                                opType <= "10";
                                stateTrans <= "001";
                                MemRead<='1';
                                pcc <= "10";
                            ccm <= '0';
                when s2c => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00010"; 
                                cacheType  <= '0';
                                opType <= "10";
                                stateTrans <= "010";
                                MemRead<='1';
                                pcc <= "10";
                            ccm <= '0';
                when s2d => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00011";
                                cacheType  <= '0';
                                opType <= "10";
                                stateTrans <= "011";
                                MemRead<='1';
                                pcc <= "10";
                            ccm <= '0';
                when s2e => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00100";
                                cacheType  <= '0';
                                opType <= "10";
                                stateTrans <= "100";
                                MemRead<='1';
                                pcc <= "10";
                            ccm <= '0';
                when s2f => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00101";
                                cacheType  <= '0';      
                                opType <= "10";
                                stateTrans <= "101";
                                MemRead<='1';
                                pcc <= "10";
                            ccm <= '0';
                 when s2g => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00110";
                                cacheType  <= '0';
                                opType <= "10";
                                stateTrans <= "110";
                                MemRead<='1';
                                pcc <= "10";
                            ccm <= '0';
                when s2h => madd(31 downto 5) <= cadd(31 downto 5);
                                    madd(4 downto 0) <= "00111";
                                    cacheType  <= '0';
                                    opType <= "10";
                                    stateTrans <= "111";
                                    MemRead<='1';
                                    pcc <= "10";
                            ccm <= '0';
                when s3 =>  IRWrite <= '1';opType <= "11";
                when s4 =>  stateCPU <= '0';opType <= "11";
                            opCode := ins(31 downto 26);            
                when s5 =>  cacheType <= '0';
                                opType <= "01";
                                pcc <= "00";
                            ccm <= '1';
                when s6 =>  MemWrite<='1';opType <= "11";
                            pcc <= "00";
                            ccm <= '1';
                when s7 =>  cacheType <= '1';
                                opType <= "00";
                                pcc <= "00";
                when s8a => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00000";
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "000";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s8b => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00001";
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "001";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0'; 
                when s8c => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00010"; 
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "010";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s8d => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00011";
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "011";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s8e => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00100";
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "100";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s8f => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00101";
                                cacheType  <= '1';      
                                opType <= "10";
                                stateTrans <= "101";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s8g => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00110";
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "110";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s8h => madd(31 downto 5) <= cadd(31 downto 5);
                                madd(4 downto 0) <= "00111";
                                cacheType  <= '1';
                                opType <= "10";
                                stateTrans <= "111";
                                MemRead<='1';
                                pcc <= "00";
                            ccm <= '0';
                when s9 => stateCPU <= '1';opType <= "11";
              end case;
                                
                                
                                
                                
                                       
                                
                                
                if (clock'event and clock='1') then
            
                    case state is
                    
                    when s0 => state <= s1;
                
                    when s1 =>  if (IHc='1') then
                                    state <= s3;
                                else 
                                    state <= s2a;
                                end if;
                    
                    when s2a => state <= s2b;
                    when s2b => state <= s2c;
                    when s2c => state <= s2d;
                    when s2d => state <= s2e;
                    when s2e => state <= s2f;
                    when s2f => state <= s2g;
                    when s2g => state <= s2h;
                    when s2h => state <= s1;
                
                    when s3 =>  state <= s4;
                
                    when s4 =>  if ( (opCode = "000000") or (opCode = "000100") ) then 
                                state <= s9;
                                end if;
                                if ( opCode = "101011" ) then 
                                state <= s5;
                                end if;
                                if ( opCode = "100011" ) then 
                                state <= s7;
                                end if;
                    when s5 =>  state <= s6;
                    when s6 =>  state <= s9;
                    when s7 =>  if (DHc='1') then
                                    state <= s9;
                                else 
                                    state <= s8a;
                                end if;
                
                    when s8a => state <= s8b;
                    when s8b => state <= s8c;
                    when s8c => state <= s8d;
                    when s8d => state <= s8e;
                    when s8e => state <= s8f;
                    when s8f => state <= s8g;
                    when s8g => state <= s8h;
                    when s8h => state <= s7;
                    when s9 =>  state <= s0;
                    end case;
            end if;
        end process;
    end architecture;
    

    
        