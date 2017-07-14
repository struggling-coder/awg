library ieee;
use ieee.std_logic_1164.all;

entity outfifo is
  generic (
  	word_length:integer := 16;
  	address_length:integer := 12);
  port (
	init, clk: in std_logic;
	push, pop: in std_logic;
	full, empty: buffer std_logic;
	datain: in std_logic_vector(word_length-1 downto 0);
	dataout: out std_logic_vector(word_length-1 downto 0)
  ) ;
end entity ; -- outfifo

architecture synth of outfifo is

-- COMPONENT RAM
  
  COMPONENT fifo_ram
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
  END COMPONENT;

  signal whead, rhead: std_logic_vector(address_length-1 to 0) := (others => '0');
  signal terminate: std_logic:= '0';
  signal addr: std_logic_vector(address_length-1 to 0);
  signal we: std_logic_vector(0 downto 0) := "0"; 
  begin

  	fifo_storage : fifo_ram
  	PORT MAP (
    clka => clk,
    wea => we,
    addra => addr,
    dina => datain,
    douta => dataout);

	synch: process(clk) is
	begin
		if rising_edge(clk) then
			if (pop = '1' and empty = '0') then
			elsif (push = '1' and full = '0') then
			end if;	
		end if;
	end process;

	logic: process(push, pop, terminate) is
	begin
		if (whead = rhead) then
			if (terminate = '1') then --write and read head have reached end
				full <= '1';
				empty <= '0';
			else
				full <= '0';
				empty <= '1';
			end if;
		else --nothing special happening here
			full <= '0'; 
			empty <= '0';
		end if;

		if (pop = '0' and push = '0') then
			addr <= rhead;
			we <= "0";
		elsif (pop = '1' and push = '0') then
			addr <= rhead;
			we <= "0";
		elsif (pop = '0' and push = '1') then
			addr <= whead;
			if (full = '0') then
				we <= "1";
			else
				we <= "0";
			end if;
		else
			if (empty = '0') then
				addr <= rhead;
				we <= "0";
			else
				addr <= whead;
				we <= "1";
			end if;
		end if;
	end process;

end architecture ; -- synth