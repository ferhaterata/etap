; ModuleID = 'test/c/14-smallintarithmetic.ll'
source_filename = "test/c/14-smallintarithmetic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i8 @foo(i8 signext %a, i8 signext %b, i8 signext %c, i8 signext %d) #0 !dbg !7 !store !15 !store !16 !store !16 !store !16 !store !17 !store !18 !store !19 !store !20 !store !17 !store !18 !store !19 !store !20 !store !17 !store !18 !store !19 !store !20 !store !17 !store !18 !store !19 !store !20 !store !17 !store !18 !store !19 !store !20 !store !17 !store !18 !store !19 !store !20 {
entry:
  %a.addr = alloca i8, align 1, !store !21
  %b.addr = alloca i8, align 1, !store !22
  %c.addr = alloca i8, align 1, !store !23
  %d.addr = alloca i8, align 1, !store !24
  %e = alloca i8, align 1, !store !25
  %f = alloca i8, align 1, !store !26
  store i8 %a, i8* %a.addr, align 1, !store !27
  call void @llvm.dbg.declare(metadata i8* %a.addr, metadata !28, metadata !DIExpression()), !dbg !29
  store i8 %b, i8* %b.addr, align 1, !store !30
  call void @llvm.dbg.declare(metadata i8* %b.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store i8 %c, i8* %c.addr, align 1, !store !33
  call void @llvm.dbg.declare(metadata i8* %c.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i8 %d, i8* %d.addr, align 1, !store !36
  call void @llvm.dbg.declare(metadata i8* %d.addr, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata i8* %e, metadata !39, metadata !DIExpression()), !dbg !40
  %0 = load i8, i8* %c.addr, align 1, !dbg !41, !store !42
  %conv = sext i8 %0 to i32, !dbg !41
  %1 = load i8, i8* %d.addr, align 1, !dbg !43, !store !44
  %conv1 = sext i8 %1 to i32, !dbg !43
  %add = add nsw i32 %conv, %conv1, !dbg !45, !store !46
  %conv2 = trunc i32 %add to i8, !dbg !41
  store i8 %conv2, i8* %e, align 1, !dbg !40, !store !47
  call void @llvm.dbg.declare(metadata i8* %f, metadata !48, metadata !DIExpression()), !dbg !49
  %2 = load i8, i8* %a.addr, align 1, !dbg !50, !store !51
  %conv3 = sext i8 %2 to i32, !dbg !50
  %3 = load i8, i8* %b.addr, align 1, !dbg !52, !store !53
  %conv4 = sext i8 %3 to i32, !dbg !52
  %add5 = add nsw i32 %conv3, %conv4, !dbg !54, !store !55
  %conv6 = trunc i32 %add5 to i8, !dbg !50
  store i8 %conv6, i8* %f, align 1, !dbg !49, !store !56
  %4 = load i8, i8* %e, align 1, !dbg !57, !store !58
  %conv7 = sext i8 %4 to i32, !dbg !57
  %5 = load i8, i8* %f, align 1, !dbg !59, !store !60
  %conv8 = sext i8 %5 to i32, !dbg !59
  %add9 = add nsw i32 %conv7, %conv8, !dbg !61, !store !62
  %conv10 = trunc i32 %add9 to i8, !dbg !57
  ret i8 %conv10, !dbg !63, !store !64
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !65 !store !72 !store !73 !store !74 !store !75 !store !74 !store !75 !store !74 !store !76 !store !74 !store !76 !store !74 !store !75 !store !74 !store !75 {
entry:
  %retval = alloca i32, align 4, !store !77
  %argc.addr = alloca i32, align 4, !store !78
  %argv.addr = alloca i8**, align 8, !store !79
  %a = alloca i32, align 4, !store !17
  %b = alloca i32, align 4, !store !18
  %c = alloca i32, align 4, !store !19
  %d = alloca i32, align 4, !store !20
  %ret = alloca i8, align 1, !store !80
  store i32 0, i32* %retval, align 4, !store !81
  store i32 %argc, i32* %argc.addr, align 4, !store !82
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !83, metadata !DIExpression()), !dbg !84
  store i8** %argv, i8*** %argv.addr, align 8, !store !85
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !86, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.declare(metadata i32* %a, metadata !88, metadata !DIExpression()), !dbg !89
  %0 = load i8**, i8*** %argv.addr, align 8, !dbg !90, !store !91
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1, !dbg !90
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !90, !store !92
  %call = call i32 @atoi(i8* %1) #3, !dbg !93
  store i32 %call, i32* %a, align 4, !dbg !89, !store !94
  call void @llvm.dbg.declare(metadata i32* %b, metadata !95, metadata !DIExpression()), !dbg !96
  %2 = load i8**, i8*** %argv.addr, align 8, !dbg !97, !store !98
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 2, !dbg !97
  %3 = load i8*, i8** %arrayidx1, align 8, !dbg !97, !store !99
  %call2 = call i32 @atoi(i8* %3) #3, !dbg !100
  store i32 %call2, i32* %b, align 4, !dbg !96, !store !101
  call void @llvm.dbg.declare(metadata i32* %c, metadata !102, metadata !DIExpression()), !dbg !103
  %4 = load i8**, i8*** %argv.addr, align 8, !dbg !104, !store !105
  %arrayidx3 = getelementptr inbounds i8*, i8** %4, i64 3, !dbg !104
  %5 = load i8*, i8** %arrayidx3, align 8, !dbg !104, !store !106
  %call4 = call i32 @atoi(i8* %5) #3, !dbg !107
  store i32 %call4, i32* %c, align 4, !dbg !103, !store !108
  call void @llvm.dbg.declare(metadata i32* %d, metadata !109, metadata !DIExpression()), !dbg !110
  %6 = load i8**, i8*** %argv.addr, align 8, !dbg !111, !store !112
  %arrayidx5 = getelementptr inbounds i8*, i8** %6, i64 4, !dbg !111
  %7 = load i8*, i8** %arrayidx5, align 8, !dbg !111, !store !113
  %call6 = call i32 @atoi(i8* %7) #3, !dbg !114
  store i32 %call6, i32* %d, align 4, !dbg !110, !store !115
  call void @llvm.dbg.declare(metadata i8* %ret, metadata !116, metadata !DIExpression()), !dbg !117
  %8 = load i32, i32* %a, align 4, !dbg !118, !store !119
  %conv = trunc i32 %8 to i8, !dbg !118
  %9 = load i32, i32* %b, align 4, !dbg !120, !store !121
  %conv7 = trunc i32 %9 to i8, !dbg !120
  %10 = load i32, i32* %c, align 4, !dbg !122, !store !123
  %conv8 = trunc i32 %10 to i8, !dbg !122
  %11 = load i32, i32* %d, align 4, !dbg !124, !store !125
  %conv9 = trunc i32 %11 to i8, !dbg !124
  %call10 = call signext i8 @foo(i8 signext %conv, i8 signext %conv7, i8 signext %conv8, i8 signext %conv9), !dbg !126
  store i8 %call10, i8* %ret, align 1, !dbg !117, !store !127
  %12 = load i8, i8* %ret, align 1, !dbg !128, !store !129
  %conv11 = sext i8 %12 to i32, !dbg !128
  ret i32 %conv11, !dbg !130, !store !131
}

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind readonly "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test/c/14-smallintarithmetic.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10, !10, !10}
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !11, line: 24, baseType: !12)
!11 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !13, line: 37, baseType: !14)
!13 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!14 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!15 = !{!"\D0* <- DiscreteDistribution(supp = -1000:1000)"}
!16 = !{!"\00~ <- DiscreteDistribution(supp = -1000:1000)"}
!17 = !{!"%a <- DiscreteDistribution(supp = -1000:1000)"}
!18 = !{!"%b <- DiscreteDistribution(supp = -1000:1000)"}
!19 = !{!"%c <- DiscreteDistribution(supp = -1000:1000)"}
!20 = !{!"%d <- DiscreteDistribution(supp = -1000:1000)"}
!21 = !{!"%a.addr <- DiscreteDistribution(supp = -1000:1000)"}
!22 = !{!"%b.addr <- DiscreteDistribution(supp = -1000:1000)"}
!23 = !{!"%c.addr <- DiscreteDistribution(supp = -1000:1000)"}
!24 = !{!"%d.addr <- DiscreteDistribution(supp = -1000:1000)"}
!25 = !{!"%e <- DiscreteDistribution(supp = -1000:1000)"}
!26 = !{!"%f <- DiscreteDistribution(supp = -1000:1000)"}
!27 = !{!"%a.addr <- %a"}
!28 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!29 = !DILocation(line: 4, column: 19, scope: !7)
!30 = !{!"%b.addr <- %b"}
!31 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 4, type: !10)
!32 = !DILocation(line: 4, column: 29, scope: !7)
!33 = !{!"%c.addr <- %c"}
!34 = !DILocalVariable(name: "c", arg: 3, scope: !7, file: !1, line: 4, type: !10)
!35 = !DILocation(line: 4, column: 39, scope: !7)
!36 = !{!"%d.addr <- %d"}
!37 = !DILocalVariable(name: "d", arg: 4, scope: !7, file: !1, line: 4, type: !10)
!38 = !DILocation(line: 4, column: 49, scope: !7)
!39 = !DILocalVariable(name: "e", scope: !7, file: !1, line: 5, type: !10)
!40 = !DILocation(line: 5, column: 10, scope: !7)
!41 = !DILocation(line: 5, column: 14, scope: !7)
!42 = !{!"%0 <- %c.addr"}
!43 = !DILocation(line: 5, column: 18, scope: !7)
!44 = !{!"%1 <- %d.addr"}
!45 = !DILocation(line: 5, column: 16, scope: !7)
!46 = !{!"%add <- %conv + %conv1"}
!47 = !{!"%e <- %conv2"}
!48 = !DILocalVariable(name: "f", scope: !7, file: !1, line: 6, type: !10)
!49 = !DILocation(line: 6, column: 10, scope: !7)
!50 = !DILocation(line: 6, column: 14, scope: !7)
!51 = !{!"%2 <- %a.addr"}
!52 = !DILocation(line: 6, column: 18, scope: !7)
!53 = !{!"%3 <- %b.addr"}
!54 = !DILocation(line: 6, column: 16, scope: !7)
!55 = !{!"%add5 <- %conv3 + %conv4"}
!56 = !{!"%f <- %conv6"}
!57 = !DILocation(line: 8, column: 10, scope: !7)
!58 = !{!"%4 <- %e"}
!59 = !DILocation(line: 8, column: 14, scope: !7)
!60 = !{!"%5 <- %f"}
!61 = !DILocation(line: 8, column: 12, scope: !7)
!62 = !{!"%add9 <- %conv7 + %conv8"}
!63 = !DILocation(line: 8, column: 3, scope: !7)
!64 = !{!"%ret <- %conv10"}
!65 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !66, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!66 = !DISubroutineType(types: !67)
!67 = !{!68, !68, !69}
!68 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!72 = !{!"P\E6\A1\00\00 <- DiscreteDistribution(supp = -1000:1000)"}
!73 = !{!"i8**\00 <- \22Type is not supported: i8**\22"}
!74 = !{!"%argc <- DiscreteDistribution(supp = -1000:1000)"}
!75 = !{!"%argv <- \22Type is not supported: i8**\22"}
!76 = !{!"%argv <- \22Type is not supported: i8**"}
!77 = !{!"%retval <- DiscreteDistribution(supp = -1000:1000)"}
!78 = !{!"%argc.addr <- DiscreteDistribution(supp = -1000:1000)"}
!79 = !{!"%argv.addr <- \22Type is not supported: i8**\22"}
!80 = !{!"%ret <- DiscreteDistribution(supp = -1000:1000)"}
!81 = !{!"%retval <- 0"}
!82 = !{!"%argc.addr <- %argc"}
!83 = !DILocalVariable(name: "argc", arg: 1, scope: !65, file: !1, line: 11, type: !68)
!84 = !DILocation(line: 11, column: 14, scope: !65)
!85 = !{!"%argv.addr <- %argv"}
!86 = !DILocalVariable(name: "argv", arg: 2, scope: !65, file: !1, line: 11, type: !69)
!87 = !DILocation(line: 11, column: 26, scope: !65)
!88 = !DILocalVariable(name: "a", scope: !65, file: !1, line: 12, type: !68)
!89 = !DILocation(line: 12, column: 7, scope: !65)
!90 = !DILocation(line: 12, column: 16, scope: !65)
!91 = !{!"%0 <- %argv.addr"}
!92 = !{!"%1 <- %arrayidx"}
!93 = !DILocation(line: 12, column: 11, scope: !65)
!94 = !{!"%a <- %call"}
!95 = !DILocalVariable(name: "b", scope: !65, file: !1, line: 12, type: !68)
!96 = !DILocation(line: 12, column: 26, scope: !65)
!97 = !DILocation(line: 12, column: 35, scope: !65)
!98 = !{!"%2 <- %argv.addr"}
!99 = !{!"%3 <- %arrayidx1"}
!100 = !DILocation(line: 12, column: 30, scope: !65)
!101 = !{!"%b <- %call2"}
!102 = !DILocalVariable(name: "c", scope: !65, file: !1, line: 12, type: !68)
!103 = !DILocation(line: 12, column: 45, scope: !65)
!104 = !DILocation(line: 12, column: 54, scope: !65)
!105 = !{!"%4 <- %argv.addr"}
!106 = !{!"%5 <- %arrayidx3"}
!107 = !DILocation(line: 12, column: 49, scope: !65)
!108 = !{!"%c <- %call4"}
!109 = !DILocalVariable(name: "d", scope: !65, file: !1, line: 13, type: !68)
!110 = !DILocation(line: 13, column: 7, scope: !65)
!111 = !DILocation(line: 13, column: 16, scope: !65)
!112 = !{!"%6 <- %argv.addr"}
!113 = !{!"%7 <- %arrayidx5"}
!114 = !DILocation(line: 13, column: 11, scope: !65)
!115 = !{!"%d <- %call6"}
!116 = !DILocalVariable(name: "ret", scope: !65, file: !1, line: 15, type: !10)
!117 = !DILocation(line: 15, column: 10, scope: !65)
!118 = !DILocation(line: 15, column: 20, scope: !65)
!119 = !{!"%8 <- %a"}
!120 = !DILocation(line: 15, column: 23, scope: !65)
!121 = !{!"%9 <- %b"}
!122 = !DILocation(line: 15, column: 26, scope: !65)
!123 = !{!"%10 <- %c"}
!124 = !DILocation(line: 15, column: 29, scope: !65)
!125 = !{!"%11 <- %d"}
!126 = !DILocation(line: 15, column: 16, scope: !65)
!127 = !{!"%ret <- %call10"}
!128 = !DILocation(line: 16, column: 10, scope: !65)
!129 = !{!"%12 <- %ret"}
!130 = !DILocation(line: 16, column: 3, scope: !65)
!131 = !{!"%ret <- %conv11"}
