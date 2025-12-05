# Basys3 Master XDC File - CORRECT 7-SEGMENT MAPPING

# ... (clk, rst, rx pins remain the same) ...
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin [get_ports clk]

set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN B18 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]

# =============================================================
# 7-Segment Display - VERIFIED MAPPING
# =============================================================
# Cathode Signals (Segments a,b,c,d,e,f,g)
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]  ; # seg[0] -> Segment A
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]  ; # seg[1] -> Segment B
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]  ; # seg[2] -> Segment C
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]  ; # seg[3] -> Segment D
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]  ; # seg[4] -> Segment E
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]  ; # seg[5] -> Segment F
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]  ; # seg[6] -> Segment G
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*]}]

# Anode Enable Signals (Active Low)
set_property PACKAGE_PIN U2 [get_ports {an[0]}]  ; # an[0] -> Rightmost digit
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]  ; # an[3] -> Leftmost digit
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]