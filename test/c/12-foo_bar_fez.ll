; ModuleID = 'test/c/12-foo_bar_fez.ll'
source_filename = "test/c/12-foo_bar_fez.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo(i32 %a) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !11, metadata !DIExpression()), !dbg !12
  %0 = load i32, i32* %a.addr, align 4, !dbg !13
  %mul = mul nsw i32 %0, 2, !dbg !14
  ret i32 %mul, !dbg !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %a, i32 %b) #0 !dbg !16 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load i32, i32* %a.addr, align 4, !dbg !23
  %1 = load i32, i32* %b.addr, align 4, !dbg !24
  %call = call i32 @foo(i32 %1), !dbg !25
  %mul = mul nsw i32 %call, 2, !dbg !26
  %add = add nsw i32 %0, %mul, !dbg !27
  ret i32 %add, !dbg !28
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @fez(i32 %a, i32 %b, i32 %c) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !32, metadata !DIExpression()), !dbg !33
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 %c, i32* %c.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %c.addr, metadata !36, metadata !DIExpression()), !dbg !37
  %0 = load i32, i32* %a.addr, align 4, !dbg !38
  %1 = load i32, i32* %a.addr, align 4, !dbg !39
  %2 = load i32, i32* %b.addr, align 4, !dbg !40
  %call = call i32 @bar(i32 %1, i32 %2), !dbg !41
  %mul = mul nsw i32 %call, 2, !dbg !42
  %add = add nsw i32 %0, %mul, !dbg !43
  %3 = load i32, i32* %c.addr, align 4, !dbg !44
  %mul1 = mul nsw i32 %3, 3, !dbg !45
  %add2 = add nsw i32 %add, %mul1, !dbg !46
  ret i32 %add2, !dbg !47
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !48 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %a = alloca i32, align 4
  %ret = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !54, metadata !DIExpression()), !dbg !55
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !56, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.declare(metadata i32* %a, metadata !58, metadata !DIExpression()), !dbg !59
  store i32 123, i32* %a, align 4, !dbg !59
  call void @llvm.dbg.declare(metadata i32* %ret, metadata !60, metadata !DIExpression()), !dbg !61
  store i32 0, i32* %ret, align 4, !dbg !61
  %0 = load i32, i32* %a, align 4, !dbg !62
  %call = call i32 @foo(i32 %0), !dbg !63
  %1 = load i32, i32* %ret, align 4, !dbg !64
  %add = add nsw i32 %1, %call, !dbg !64
  store i32 %add, i32* %ret, align 4, !dbg !64
  %2 = load i32, i32* %a, align 4, !dbg !65
  %3 = load i32, i32* %ret, align 4, !dbg !66
  %call1 = call i32 @bar(i32 %2, i32 %3), !dbg !67
  %4 = load i32, i32* %ret, align 4, !dbg !68
  %add2 = add nsw i32 %4, %call1, !dbg !68
  store i32 %add2, i32* %ret, align 4, !dbg !68
  %5 = load i32, i32* %a, align 4, !dbg !69
  %6 = load i32, i32* %ret, align 4, !dbg !70
  %call3 = call i32 @fez(i32 %5, i32 %6, i32 123), !dbg !71
  %7 = load i32, i32* %ret, align 4, !dbg !72
  %add4 = add nsw i32 %7, %call3, !dbg !72
  store i32 %add4, i32* %ret, align 4, !dbg !72
  %8 = load i32, i32* %ret, align 4, !dbg !73
  ret i32 %8, !dbg !74
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test/c/12-foo_bar_fez.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !8, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!12 = !DILocation(line: 10, column: 13, scope: !7)
!13 = !DILocation(line: 10, column: 25, scope: !7)
!14 = !DILocation(line: 10, column: 27, scope: !7)
!15 = !DILocation(line: 10, column: 18, scope: !7)
!16 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 12, type: !17, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!10, !10, !10}
!19 = !DILocalVariable(name: "a", arg: 1, scope: !16, file: !1, line: 12, type: !10)
!20 = !DILocation(line: 12, column: 13, scope: !16)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !16, file: !1, line: 12, type: !10)
!22 = !DILocation(line: 12, column: 20, scope: !16)
!23 = !DILocation(line: 12, column: 33, scope: !16)
!24 = !DILocation(line: 12, column: 41, scope: !16)
!25 = !DILocation(line: 12, column: 37, scope: !16)
!26 = !DILocation(line: 12, column: 44, scope: !16)
!27 = !DILocation(line: 12, column: 35, scope: !16)
!28 = !DILocation(line: 12, column: 25, scope: !16)
!29 = distinct !DISubprogram(name: "fez", scope: !1, file: !1, line: 14, type: !30, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !10}
!32 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 14, type: !10)
!33 = !DILocation(line: 14, column: 13, scope: !29)
!34 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 14, type: !10)
!35 = !DILocation(line: 14, column: 20, scope: !29)
!36 = !DILocalVariable(name: "c", arg: 3, scope: !29, file: !1, line: 14, type: !10)
!37 = !DILocation(line: 14, column: 27, scope: !29)
!38 = !DILocation(line: 14, column: 40, scope: !29)
!39 = !DILocation(line: 14, column: 48, scope: !29)
!40 = !DILocation(line: 14, column: 51, scope: !29)
!41 = !DILocation(line: 14, column: 44, scope: !29)
!42 = !DILocation(line: 14, column: 54, scope: !29)
!43 = !DILocation(line: 14, column: 42, scope: !29)
!44 = !DILocation(line: 14, column: 60, scope: !29)
!45 = !DILocation(line: 14, column: 62, scope: !29)
!46 = !DILocation(line: 14, column: 58, scope: !29)
!47 = !DILocation(line: 14, column: 32, scope: !29)
!48 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !49, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!10, !10, !51}
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!54 = !DILocalVariable(name: "argc", arg: 1, scope: !48, file: !1, line: 16, type: !10)
!55 = !DILocation(line: 16, column: 14, scope: !48)
!56 = !DILocalVariable(name: "argv", arg: 2, scope: !48, file: !1, line: 16, type: !51)
!57 = !DILocation(line: 16, column: 26, scope: !48)
!58 = !DILocalVariable(name: "a", scope: !48, file: !1, line: 17, type: !10)
!59 = !DILocation(line: 17, column: 7, scope: !48)
!60 = !DILocalVariable(name: "ret", scope: !48, file: !1, line: 18, type: !10)
!61 = !DILocation(line: 18, column: 7, scope: !48)
!62 = !DILocation(line: 20, column: 14, scope: !48)
!63 = !DILocation(line: 20, column: 10, scope: !48)
!64 = !DILocation(line: 20, column: 7, scope: !48)
!65 = !DILocation(line: 21, column: 14, scope: !48)
!66 = !DILocation(line: 21, column: 17, scope: !48)
!67 = !DILocation(line: 21, column: 10, scope: !48)
!68 = !DILocation(line: 21, column: 7, scope: !48)
!69 = !DILocation(line: 22, column: 14, scope: !48)
!70 = !DILocation(line: 22, column: 17, scope: !48)
!71 = !DILocation(line: 22, column: 10, scope: !48)
!72 = !DILocation(line: 22, column: 7, scope: !48)
!73 = !DILocation(line: 24, column: 10, scope: !48)
!74 = !DILocation(line: 24, column: 3, scope: !48)
