(gdb) disassemble mandel
Dump of assembler code for function mandel:
   0x0000000000400b30 <+0>:     vmovsd 0x1a0(%rip),%xmm6        # 0x400cd8
   0x0000000000400b38 <+8>:     mov    $0x6020a0,%esi
   0x0000000000400b3d <+13>:    vmovsd 0x19b(%rip),%xmm5        # 0x400ce0
   0x0000000000400b45 <+21>:    mov    $0x770400,%r8d
   0x0000000000400b4b <+27>:    mov    $0xfffffe0c,%edi
   0x0000000000400b50 <+32>:    vxorpd %xmm4,%xmm4,%xmm4
   0x0000000000400b54 <+36>:    mov    %rsi,%rcx
   0x0000000000400b57 <+39>:    mov    $0xfffffc18,%edx
   0x0000000000400b5c <+44>:    vcvtsi2sd %edi,%xmm4,%xmm4
   0x0000000000400b60 <+48>:    vmulsd %xmm6,%xmm4,%xmm4
   0x0000000000400b64 <+52>:    nopl   0x0(%rax)
   0x0000000000400b68 <+56>:    vxorpd %xmm3,%xmm3,%xmm3
   0x0000000000400b6c <+60>:    vmovapd %xmm4,%xmm0
   0x0000000000400b70 <+64>:    xor    %eax,%eax
   0x0000000000400b72 <+66>:    vcvtsi2sd %edx,%xmm3,%xmm3
   0x0000000000400b76 <+70>:    vmulsd %xmm6,%xmm3,%xmm3
   0x0000000000400b7a <+74>:    vmovapd %xmm3,%xmm1
   0x0000000000400b7e <+78>:    jmp    0x400b88 <mandel+88>
   0x0000000000400b80 <+80>:    cmp    $0xff,%rax
   0x0000000000400b86 <+86>:    je     0x400bba <mandel+138>
   0x0000000000400b88 <+88>:    vmovapd %xmm1,%xmm2
   0x0000000000400b8c <+92>:    add    $0x1,%rax
   0x0000000000400b90 <+96>:    vfmadd132sd %xmm1,%xmm3,%xmm2
   0x0000000000400b95 <+101>:   vfnmadd231sd %xmm0,%xmm0,%xmm2
   0x0000000000400b9a <+106>:   vmulsd %xmm0,%xmm1,%xmm0
   0x0000000000400b9e <+110>:   vmovapd %xmm2,%xmm1
   0x0000000000400ba2 <+114>:   vfmadd132sd %xmm5,%xmm4,%xmm0
   0x0000000000400ba7 <+119>:   vmulsd %xmm0,%xmm0,%xmm2
   0x0000000000400bab <+123>:   vfmadd231sd %xmm1,%xmm1,%xmm2
   0x0000000000400bb0 <+128>:   vcomisd 0x130(%rip),%xmm2        # 0x400ce8
   0x0000000000400bb8 <+136>:   jbe    0x400b80 <mandel+80>
   0x0000000000400bba <+138>:   add    $0x1,%edx
   0x0000000000400bbd <+141>:   mov    %al,(%rcx)
   0x0000000000400bbf <+143>:   add    $0x1,%rcx
   0x0000000000400bc3 <+147>:   cmp    $0x1f4,%edx
   0x0000000000400bc9 <+153>:   jne    0x400b68 <mandel+56>
   0x0000000000400bcb <+155>:   add    $0x5dc,%rsi
   0x0000000000400bd2 <+162>:   add    $0x1,%edi
   0x0000000000400bd5 <+165>:   cmp    %rsi,%r8
   0x0000000000400bd8 <+168>:   jne    0x400b50 <mandel+32>
   0x0000000000400bde <+174>:   repz retq 
End of assembler dump.

