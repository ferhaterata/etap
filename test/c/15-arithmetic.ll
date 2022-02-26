; ModuleID = 'test/c/15-arithmetic.ll'
source_filename = "test/c/15-arithmetic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo(i32 %a, i32 %b, i32 %c) #0 !dbg !7 !store !11 !formal !12 !formal !13 !formal !14 {
entry:
  %a.addr = alloca i32, align 4, !store !15
  %b.addr = alloca i32, align 4, !store !16
  %c.addr = alloca i32, align 4, !store !17
  %result = alloca i32, align 4, !store !18
  %d = alloca i32, align 4, !store !19
  %e = alloca i32, align 4, !store !20
  %f = alloca i32, align 4, !store !21
  %g = alloca i32, align 4, !store !22
  store i32 %a, i32* %a.addr, align 4, !store !23
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 %b, i32* %b.addr, align 4, !store !26
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !27, metadata !DIExpression()), !dbg !28
  store i32 %c, i32* %c.addr, align 4, !store !29
  call void @llvm.dbg.declare(metadata i32* %c.addr, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %result, metadata !32, metadata !DIExpression()), !dbg !33
  %0 = load i32, i32* %a.addr, align 4, !dbg !34, !store !35
  %add = add nsw i32 123, %0, !dbg !36, !store !37
  store i32 %add, i32* %result, align 4, !dbg !33, !store !38
  %1 = load i32, i32* %a.addr, align 4, !dbg !39, !store !41
  %cmp = icmp sgt i32 %1, 0, !dbg !42, !store !43
  br i1 %cmp, label %if.then, label %if.else7, !dbg !44, !store !45

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %d, metadata !46, metadata !DIExpression()), !dbg !48
  %2 = load i32, i32* %a.addr, align 4, !dbg !49, !store !50
  %3 = load i32, i32* %b.addr, align 4, !dbg !51, !store !52
  %mul = mul nsw i32 %2, %3, !dbg !53, !store !54
  store i32 %mul, i32* %d, align 4, !dbg !48, !store !55
  call void @llvm.dbg.declare(metadata i32* %e, metadata !56, metadata !DIExpression()), !dbg !57
  %4 = load i32, i32* %b.addr, align 4, !dbg !58, !store !59
  %5 = load i32, i32* %c.addr, align 4, !dbg !60, !store !61
  %div = sdiv i32 %4, %5, !dbg !62, !store !63
  store i32 %div, i32* %e, align 4, !dbg !57, !store !64
  %6 = load i32, i32* %d, align 4, !dbg !65, !store !67
  %7 = load i32, i32* %e, align 4, !dbg !68, !store !69
  %cmp1 = icmp eq i32 %6, %7, !dbg !70, !store !71
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !72, !store !73

if.then2:                                         ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %f, metadata !74, metadata !DIExpression()), !dbg !76
  %8 = load i32, i32* %d, align 4, !dbg !77, !store !78
  %9 = load i32, i32* %e, align 4, !dbg !79, !store !80
  %mul3 = mul nsw i32 %8, %9, !dbg !81, !store !82
  store i32 %mul3, i32* %f, align 4, !dbg !76, !store !83
  %10 = load i32, i32* %result, align 4, !dbg !84, !store !85
  %11 = load i32, i32* %f, align 4, !dbg !86, !store !87
  %mul4 = mul nsw i32 2, %11, !dbg !88, !store !89
  %sub = sub nsw i32 %10, %mul4, !dbg !90, !store !91
  store i32 %sub, i32* %result, align 4, !dbg !92, !store !93
  br label %if.end, !dbg !94, !store !95

if.else:                                          ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %g, metadata !96, metadata !DIExpression()), !dbg !98
  store i32 987, i32* %g, align 4, !dbg !98, !store !99
  %12 = load i32, i32* %g, align 4, !dbg !100, !store !101
  %13 = load i32, i32* %c.addr, align 4, !dbg !102, !store !103
  %mul5 = mul nsw i32 %12, %13, !dbg !104, !store !105
  %14 = load i32, i32* %e, align 4, !dbg !106, !store !107
  %mul6 = mul nsw i32 %mul5, %14, !dbg !108, !store !109
  store i32 %mul6, i32* %result, align 4, !dbg !110, !store !111
  br label %if.end, !store !112

if.end:                                           ; preds = %if.else, %if.then2
  br label %if.end8, !dbg !113, !store !114

if.else7:                                         ; preds = %entry
  store i32 321, i32* %result, align 4, !dbg !115, !store !117
  br label %if.end8, !store !118

if.end8:                                          ; preds = %if.else7, %if.end
  %15 = load i32, i32* %result, align 4, !dbg !119, !store !120
  ret i32 %15, !dbg !121, !store !122
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test/c/15-arithmetic.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !8, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.else <- F; if.end <- F; if.else7 <- F; if.end8 <- F"}
!12 = !{!"%a <- DiscreteDistribution(0)"}
!13 = !{!"%b <- DiscreteDistribution(0)"}
!14 = !{!"%c <- DiscreteDistribution(0)"}
!15 = !{!"%a.addr <- 0"}
!16 = !{!"%b.addr <- 0"}
!17 = !{!"%c.addr <- 0"}
!18 = !{!"%result <- 0"}
!19 = !{!"%d <- 0"}
!20 = !{!"%e <- 0"}
!21 = !{!"%f <- 0"}
!22 = !{!"%g <- 0"}
!23 = !{!"%a.addr <- %a"}
!24 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 1, type: !10)
!25 = !DILocation(line: 1, column: 13, scope: !7)
!26 = !{!"%b.addr <- %b"}
!27 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 1, type: !10)
!28 = !DILocation(line: 1, column: 20, scope: !7)
!29 = !{!"%c.addr <- %c"}
!30 = !DILocalVariable(name: "c", arg: 3, scope: !7, file: !1, line: 1, type: !10)
!31 = !DILocation(line: 1, column: 27, scope: !7)
!32 = !DILocalVariable(name: "result", scope: !7, file: !1, line: 2, type: !10)
!33 = !DILocation(line: 2, column: 7, scope: !7)
!34 = !DILocation(line: 2, column: 22, scope: !7)
!35 = !{!"%0 <- %a.addr"}
!36 = !DILocation(line: 2, column: 20, scope: !7)
!37 = !{!"%add <- 123 + %0"}
!38 = !{!"%result <- %add"}
!39 = !DILocation(line: 4, column: 7, scope: !40)
!40 = distinct !DILexicalBlock(scope: !7, file: !1, line: 4, column: 7)
!41 = !{!"%1 <- %a.addr"}
!42 = !DILocation(line: 4, column: 9, scope: !40)
!43 = !{!"%cmp <- %1 - 0; if (is.numeric(%cmp)) %cmp <- DiscreteDistribution(%cmp); %cmp <- 1 - p(%cmp)(0)"}
!44 = !DILocation(line: 4, column: 7, scope: !7)
!45 = !{!"%entry%if.then <- round(%cmp, 2); %entry%if.else7 <- round(1 - %cmp, 2); entry <- T"}
!46 = !DILocalVariable(name: "d", scope: !47, file: !1, line: 5, type: !10)
!47 = distinct !DILexicalBlock(scope: !40, file: !1, line: 4, column: 14)
!48 = !DILocation(line: 5, column: 9, scope: !47)
!49 = !DILocation(line: 5, column: 13, scope: !47)
!50 = !{!"%2 <- %a.addr"}
!51 = !DILocation(line: 5, column: 17, scope: !47)
!52 = !{!"%3 <- %b.addr"}
!53 = !DILocation(line: 5, column: 15, scope: !47)
!54 = !{!"%mul <- %2 * %3"}
!55 = !{!"%d <- %mul"}
!56 = !DILocalVariable(name: "e", scope: !47, file: !1, line: 6, type: !10)
!57 = !DILocation(line: 6, column: 9, scope: !47)
!58 = !DILocation(line: 6, column: 13, scope: !47)
!59 = !{!"%4 <- %b.addr"}
!60 = !DILocation(line: 6, column: 17, scope: !47)
!61 = !{!"%5 <- %c.addr"}
!62 = !DILocation(line: 6, column: 15, scope: !47)
!63 = !{!"%div <- %4 / %5"}
!64 = !{!"%e <- %div"}
!65 = !DILocation(line: 7, column: 9, scope: !66)
!66 = distinct !DILexicalBlock(scope: !47, file: !1, line: 7, column: 9)
!67 = !{!"%6 <- %d"}
!68 = !DILocation(line: 7, column: 14, scope: !66)
!69 = !{!"%7 <- %e"}
!70 = !DILocation(line: 7, column: 11, scope: !66)
!71 = !{!"%cmp1 <- %6 - %7; if (is.numeric(%cmp1)) %cmp1 <- DiscreteDistribution(%cmp1); %cmp1 <- p(%cmp1)(0) - p(%cmp1)(-1)"}
!72 = !DILocation(line: 7, column: 9, scope: !47)
!73 = !{!"%if.then%if.then2 <- round(%cmp1, 2); %if.then%if.else <- round(1 - %cmp1, 2); if.then <- T; entry <- F"}
!74 = !DILocalVariable(name: "f", scope: !75, file: !1, line: 8, type: !10)
!75 = distinct !DILexicalBlock(scope: !66, file: !1, line: 7, column: 17)
!76 = !DILocation(line: 8, column: 11, scope: !75)
!77 = !DILocation(line: 8, column: 15, scope: !75)
!78 = !{!"%8 <- %d"}
!79 = !DILocation(line: 8, column: 19, scope: !75)
!80 = !{!"%9 <- %e"}
!81 = !DILocation(line: 8, column: 17, scope: !75)
!82 = !{!"%mul3 <- %8 * %9"}
!83 = !{!"%f <- %mul3"}
!84 = !DILocation(line: 9, column: 16, scope: !75)
!85 = !{!"%10 <- %result"}
!86 = !DILocation(line: 9, column: 29, scope: !75)
!87 = !{!"%11 <- %f"}
!88 = !DILocation(line: 9, column: 27, scope: !75)
!89 = !{!"%mul4 <- 2 * %11"}
!90 = !DILocation(line: 9, column: 23, scope: !75)
!91 = !{!"%sub <- %10 - %mul4"}
!92 = !DILocation(line: 9, column: 14, scope: !75)
!93 = !{!"%result <- %sub"}
!94 = !DILocation(line: 10, column: 5, scope: !75)
!95 = !{!"%if.then2%if.end <- 1.00; if.then2 <- T; if.then <- F"}
!96 = !DILocalVariable(name: "g", scope: !97, file: !1, line: 11, type: !10)
!97 = distinct !DILexicalBlock(scope: !66, file: !1, line: 10, column: 12)
!98 = !DILocation(line: 11, column: 11, scope: !97)
!99 = !{!"%g <- 987"}
!100 = !DILocation(line: 12, column: 16, scope: !97)
!101 = !{!"%12 <- %g"}
!102 = !DILocation(line: 12, column: 20, scope: !97)
!103 = !{!"%13 <- %c.addr"}
!104 = !DILocation(line: 12, column: 18, scope: !97)
!105 = !{!"%mul5 <- %12 * %13"}
!106 = !DILocation(line: 12, column: 24, scope: !97)
!107 = !{!"%14 <- %e"}
!108 = !DILocation(line: 12, column: 22, scope: !97)
!109 = !{!"%mul6 <- %mul5 * %14"}
!110 = !DILocation(line: 12, column: 14, scope: !97)
!111 = !{!"%result <- %mul6"}
!112 = !{!"%if.else%if.end <- 1.00; if.else <- T; if.then <- F"}
!113 = !DILocation(line: 14, column: 3, scope: !47)
!114 = !{!"%if.end%if.end8 <- 1.00; if.end <- T; if.else <- F; if.then2 <- F"}
!115 = !DILocation(line: 15, column: 12, scope: !116)
!116 = distinct !DILexicalBlock(scope: !40, file: !1, line: 14, column: 10)
!117 = !{!"%result <- 321"}
!118 = !{!"%if.else7%if.end8 <- 1.00; if.else7 <- T; entry <- F"}
!119 = !DILocation(line: 18, column: 10, scope: !7)
!120 = !{!"%15 <- %result"}
!121 = !DILocation(line: 18, column: 3, scope: !7)
!122 = !{!"%ret <- %15; if.end8 <- T; if.else7 <- F; if.end <- F"}
