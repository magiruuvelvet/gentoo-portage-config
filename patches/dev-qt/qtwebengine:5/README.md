# Patches by me

Various build and segmentation fault fixes on a pure LLVM userland with absent GNU libraries. Chromium <3 GNU (joke)

 - `disable-stack-tracing.patch`
 - `disable-crash-reporting.patch`
 - `remove-gnu-runtime-linkage.patch`

# Other patches

 - `OpenMandrivaAssociation-qt5-qtwebengine-cfd17f1ecf4068ef84df2019e965518ae33ad5b2.patch`
   https://github.com/OpenMandrivaAssociation/qt5-qtwebengine/commit/cfd17f1ecf4068ef84df2019e965518ae33ad5b2
   addressing runtime problems when compiled with clang 14+

 - all other files: https://bugs.gentoo.org/836604 attachment 769283
   addressing runtime problems when compiled with clang 14+
