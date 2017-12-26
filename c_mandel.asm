(gdb) disassemble mandel
Dump of assembler code for function mandel:
   0x0000000000400830 <+0>:     vmovsd 0x160(%rip),%xmm6        # 0x400998
   0x0000000000400838 <+8>:     mov    $0x6010a0,%esi
   0x000000000040083d <+13>:    vmovsd 0x15b(%rip),%xmm5        # 0x4009a0
   0x0000000000400845 <+21>:    mov    $0x76f400,%r8d
   0x000000000040084b <+27>:    mov    $0xfffffe0c,%edi
   0x0000000000400850 <+32>:    vxorpd %xmm4,%xmm4,%xmm4
   0x0000000000400854 <+36>:    mov    %rsi,%rcx
   0x0000000000400857 <+39>:    mov    $0xfffffc18,%edx
   0x000000000040085c <+44>:    vcvtsi2sd %edi,%xmm4,%xmm4
   0x0000000000400860 <+48>:    vmulsd %xmm6,%xmm4,%xmm4
   0x0000000000400864 <+52>:    nopl   0x0(%rax)
   0x0000000000400868 <+56>:    vxorpd %xmm3,%xmm3,%xmm3
   0x000000000040086c <+60>:    vmovapd %xmm4,%xmm0
   0x0000000000400870 <+64>:    xor    %eax,%eax
   0x0000000000400872 <+66>:    vcvtsi2sd %edx,%xmm3,%xmm3
   0x0000000000400876 <+70>:    vmulsd %xmm6,%xmm3,%xmm3
   0x000000000040087a <+74>:    vmovapd %xmm3,%xmm1
   0x000000000040087e <+78>:    jmp    0x400888 <mandel+88>
   0x0000000000400880 <+80>:    cmp    $0xff,%rax
   0x0000000000400886 <+86>:    je     0x4008ba <mandel+138>
   0x0000000000400888 <+88>:    vmovapd %xmm1,%xmm2
   0x000000000040088c <+92>:    add    $0x1,%rax
   0x0000000000400890 <+96>:    vfmadd132sd %xmm1,%xmm3,%xmm2
   0x0000000000400895 <+101>:   vfnmadd231sd %xmm0,%xmm0,%xmm2
   0x000000000040089a <+106>:   vmulsd %xmm0,%xmm1,%xmm0
   0x000000000040089e <+110>:   vmovapd %xmm2,%xmm1
   0x00000000004008a2 <+114>:   vfmadd132sd %xmm5,%xmm4,%xmm0
   0x00000000004008a7 <+119>:   vmulsd %xmm0,%xmm0,%xmm2
   0x00000000004008ab <+123>:   vfmadd231sd %xmm1,%xmm1,%xmm2
   0x00000000004008b0 <+128>:   vcomisd 0xf0(%rip),%xmm2        # 0x4009a8
   0x00000000004008b8 <+136>:   jbe    0x400880 <mandel+80>
   0x00000000004008ba <+138>:   add    $0x1,%edx
   0x00000000004008bd <+141>:   mov    %al,(%rcx)
   0x00000000004008bf <+143>:   add    $0x1,%rcx
   0x00000000004008c3 <+147>:   cmp    $0x1f4,%edx
   0x00000000004008c9 <+153>:   jne    0x400868 <mandel+56>
   0x00000000004008cb <+155>:   add    $0x5dc,%rsi
   0x00000000004008d2 <+162>:   add    $0x1,%edi
   0x00000000004008d5 <+165>:   cmp    %rsi,%r8
   0x00000000004008d8 <+168>:   jne    0x400850 <mandel+32>
   0x00000000004008de <+174>:   repz retq 
End of assembler dump.

