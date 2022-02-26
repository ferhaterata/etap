; ModuleID = 'test/c/06-nestedbranches.ll'
source_filename = "test/c/06-nestedbranches.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"True\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"Truish\0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"False\0A\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"Finn\0A\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"Jake\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @profiled(i32 %argc, i32 %i) #0 !dbg !7 !store !11 !store !12 {
entry:
  %argc.addr = alloca i32, align 4, !store !13
  %i.addr = alloca i32, align 4, !store !14
  store i32 %argc, i32* %argc.addr, align 4, !store !15
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 %i, i32* %i.addr, align 4, !store !18
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !19, metadata !DIExpression()), !dbg !20
  %0 = load i32, i32* %i.addr, align 4, !dbg !21, !store !23
  %1 = load i32, i32* %argc.addr, align 4, !dbg !24, !store !25
  %add = add nsw i32 %0, %1, !dbg !26, !store !27
  %rem = srem i32 %add, 3, !dbg !28, !store !29
  %tobool = icmp ne i32 %rem, 0, !dbg !28, !store !30
  br i1 %tobool, label %if.then, label %if.else6, !dbg !31, !store !32

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %i.addr, align 4, !dbg !33, !store !36
  %3 = load i32, i32* %argc.addr, align 4, !dbg !37, !store !38
  %add1 = add nsw i32 %2, %3, !dbg !39, !store !40
  %rem2 = srem i32 %add1, 6, !dbg !41, !store !42
  %tobool3 = icmp ne i32 %rem2, 0, !dbg !41, !store !30
  br i1 %tobool3, label %if.then4, label %if.else, !dbg !43, !store !44

if.then4:                                         ; preds = %if.then
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0)), !dbg !45
  br label %if.end, !dbg !47, !store !48

if.else:                                          ; preds = %if.then
  %call5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0)), !dbg !49
  br label %if.end, !store !51

if.end:                                           ; preds = %if.else, %if.then4
  br label %if.end8, !dbg !52, !store !53

if.else6:                                         ; preds = %entry
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0)), !dbg !54
  br label %if.end8, !store !56

if.end8:                                          ; preds = %if.else6, %if.end
  %4 = load i32, i32* %i.addr, align 4, !dbg !57, !store !59
  %5 = load i32, i32* %argc.addr, align 4, !dbg !60, !store !61
  %add9 = add nsw i32 %4, %5, !dbg !62, !store !63
  %rem10 = srem i32 %add9, 5, !dbg !64, !store !65
  %tobool11 = icmp ne i32 %rem10, 0, !dbg !64, !store !30
  br i1 %tobool11, label %if.then12, label %if.else14, !dbg !66, !store !67

if.then12:                                        ; preds = %if.end8
  %call13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)), !dbg !68
  br label %if.end16, !dbg !70, !store !71

if.else14:                                        ; preds = %if.end8
  %call15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0)), !dbg !72
  br label %if.end16, !store !74

if.end16:                                         ; preds = %if.else14, %if.then12
  ret void, !dbg !75, !store !76
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !77 !store !11 !store !83 {
entry:
  %retval = alloca i32, align 4, !store !84
  %argc.addr = alloca i32, align 4, !store !13
  %argv.addr = alloca i8**, align 8, !store !85
  %j = alloca i32, align 4, !store !86
  %e = alloca i32, align 4, !store !87
  %i = alloca i32, align 4, !store !12
  %e1 = alloca i32, align 4, !store !88
  store i32 0, i32* %retval, align 4, !store !89
  store i32 %argc, i32* %argc.addr, align 4, !store !15
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !90, metadata !DIExpression()), !dbg !91
  store i8** %argv, i8*** %argv.addr, align 8, !store !92
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !93, metadata !DIExpression()), !dbg !94
  call void @llvm.dbg.declare(metadata i32* %j, metadata !95, metadata !DIExpression()), !dbg !97
  store i32 0, i32* %j, align 4, !dbg !97, !store !98
  call void @llvm.dbg.declare(metadata i32* %e, metadata !99, metadata !DIExpression()), !dbg !100
  store i32 100, i32* %e, align 4, !dbg !100, !store !101
  br label %for.cond, !dbg !102, !store !103

for.cond:                                         ; preds = %for.inc5, %entry
  %0 = load i32, i32* %j, align 4, !dbg !104, !store !106
  %1 = load i32, i32* %e, align 4, !dbg !107, !store !108
  %cmp = icmp ne i32 %0, %1, !dbg !109, !store !30
  br i1 %cmp, label %for.body, label %for.end7, !dbg !110, !store !111

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %i, metadata !112, metadata !DIExpression()), !dbg !115
  store i32 0, i32* %i, align 4, !dbg !115, !store !116
  call void @llvm.dbg.declare(metadata i32* %e1, metadata !117, metadata !DIExpression()), !dbg !118
  %2 = load i8**, i8*** %argv.addr, align 8, !dbg !119, !store !120
  %arrayidx = getelementptr inbounds i8*, i8** %2, i64 1, !dbg !119
  %3 = load i8*, i8** %arrayidx, align 8, !dbg !119, !store !121
  %call = call i32 @atoi(i8* %3) #4, !dbg !122
  store i32 %call, i32* %e1, align 4, !dbg !118, !store !123
  br label %for.cond2, !dbg !124, !store !125

for.cond2:                                        ; preds = %for.inc, %for.body
  %4 = load i32, i32* %i, align 4, !dbg !126, !store !128
  %5 = load i32, i32* %e1, align 4, !dbg !129, !store !130
  %cmp3 = icmp slt i32 %4, %5, !dbg !131, !store !30
  br i1 %cmp3, label %for.body4, label %for.end, !dbg !132, !store !133

for.body4:                                        ; preds = %for.cond2
  %6 = load i32, i32* %argc.addr, align 4, !dbg !134, !store !136
  %7 = load i32, i32* %i, align 4, !dbg !137, !store !138
  call void @profiled(i32 %6, i32 %7), !dbg !139
  br label %for.inc, !dbg !140, !store !141

for.inc:                                          ; preds = %for.body4
  %8 = load i32, i32* %i, align 4, !dbg !142, !store !143
  %inc = add nsw i32 %8, 1, !dbg !142, !store !144
  store i32 %inc, i32* %i, align 4, !dbg !142, !store !145
  br label %for.cond2, !dbg !146, !llvm.loop !147, !store !149

for.end:                                          ; preds = %for.cond2
  br label %for.inc5, !dbg !150, !store !151

for.inc5:                                         ; preds = %for.end
  %9 = load i32, i32* %j, align 4, !dbg !152, !store !153
  %inc6 = add nsw i32 %9, 1, !dbg !152, !store !154
  store i32 %inc6, i32* %j, align 4, !dbg !152, !store !155
  br label %for.cond, !dbg !156, !llvm.loop !157, !store !159

for.end7:                                         ; preds = %for.cond
  ret i32 0, !dbg !160, !store !161
}

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test/c/06-nestedbranches.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "profiled", scope: !1, file: !1, line: 4, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!"%argc <- DiscreteDistribution(supp = -1000:1000)"}
!12 = !{!"%i <- DiscreteDistribution(supp = -1000:1000)"}
!13 = !{!"%argc.addr <- DiscreteDistribution(supp = -1000:1000)"}
!14 = !{!"%i.addr <- DiscreteDistribution(supp = -1000:1000)"}
!15 = !{!"%argc.addr <- %argc"}
!16 = !DILocalVariable(name: "argc", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!17 = !DILocation(line: 4, column: 19, scope: !7)
!18 = !{!"%i.addr <- %i"}
!19 = !DILocalVariable(name: "i", arg: 2, scope: !7, file: !1, line: 4, type: !10)
!20 = !DILocation(line: 4, column: 29, scope: !7)
!21 = !DILocation(line: 5, column: 8, scope: !22)
!22 = distinct !DILexicalBlock(scope: !7, file: !1, line: 5, column: 7)
!23 = !{!"%0 <- %i.addr"}
!24 = !DILocation(line: 5, column: 12, scope: !22)
!25 = !{!"%1 <- %argc.addr"}
!26 = !DILocation(line: 5, column: 10, scope: !22)
!27 = !{!"%add <- %0 + %1"}
!28 = !DILocation(line: 5, column: 18, scope: !22)
!29 = !{!"%rem <- %add / 3"}
!30 = !{!""}
!31 = !DILocation(line: 5, column: 7, scope: !7)
!32 = !{!"%entry%if.else6 <- %tobool; %entry%if.then <- 1 - %tobool"}
!33 = !DILocation(line: 6, column: 10, scope: !34)
!34 = distinct !DILexicalBlock(scope: !35, file: !1, line: 6, column: 9)
!35 = distinct !DILexicalBlock(scope: !22, file: !1, line: 5, column: 23)
!36 = !{!"%2 <- %i.addr"}
!37 = !DILocation(line: 6, column: 14, scope: !34)
!38 = !{!"%3 <- %argc.addr"}
!39 = !DILocation(line: 6, column: 12, scope: !34)
!40 = !{!"%add1 <- %2 + %3"}
!41 = !DILocation(line: 6, column: 20, scope: !34)
!42 = !{!"%rem2 <- %add1 / 6"}
!43 = !DILocation(line: 6, column: 9, scope: !35)
!44 = !{!"%if.then%if.else <- %tobool3; %if.then%if.then4 <- 1 - %tobool3"}
!45 = !DILocation(line: 7, column: 7, scope: !46)
!46 = distinct !DILexicalBlock(scope: !34, file: !1, line: 6, column: 25)
!47 = !DILocation(line: 8, column: 5, scope: !46)
!48 = !{!"%if.then4%if.end <- 1.00"}
!49 = !DILocation(line: 9, column: 7, scope: !50)
!50 = distinct !DILexicalBlock(scope: !34, file: !1, line: 8, column: 12)
!51 = !{!"%if.else%if.end <- 1.00"}
!52 = !DILocation(line: 11, column: 3, scope: !35)
!53 = !{!"%if.end%if.end8 <- 1.00"}
!54 = !DILocation(line: 12, column: 5, scope: !55)
!55 = distinct !DILexicalBlock(scope: !22, file: !1, line: 11, column: 10)
!56 = !{!"%if.else6%if.end8 <- 1.00"}
!57 = !DILocation(line: 14, column: 8, scope: !58)
!58 = distinct !DILexicalBlock(scope: !7, file: !1, line: 14, column: 7)
!59 = !{!"%4 <- %i.addr"}
!60 = !DILocation(line: 14, column: 12, scope: !58)
!61 = !{!"%5 <- %argc.addr"}
!62 = !DILocation(line: 14, column: 10, scope: !58)
!63 = !{!"%add9 <- %4 + %5"}
!64 = !DILocation(line: 14, column: 18, scope: !58)
!65 = !{!"%rem10 <- %add9 / 5"}
!66 = !DILocation(line: 14, column: 7, scope: !7)
!67 = !{!"%if.end8%if.else14 <- %tobool11; %if.end8%if.then12 <- 1 - %tobool11"}
!68 = !DILocation(line: 15, column: 5, scope: !69)
!69 = distinct !DILexicalBlock(scope: !58, file: !1, line: 14, column: 23)
!70 = !DILocation(line: 16, column: 3, scope: !69)
!71 = !{!"%if.then12%if.end16 <- 1.00"}
!72 = !DILocation(line: 17, column: 5, scope: !73)
!73 = distinct !DILexicalBlock(scope: !58, file: !1, line: 16, column: 10)
!74 = !{!"%if.else14%if.end16 <- 1.00"}
!75 = !DILocation(line: 19, column: 1, scope: !7)
!76 = !{!"%ret <- NA"}
!77 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 21, type: !78, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!78 = !DISubroutineType(types: !79)
!79 = !{!10, !10, !80}
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!83 = !{!"%argv <- \22Type is not supported: i8**\22"}
!84 = !{!"%retval <- DiscreteDistribution(supp = -1000:1000)"}
!85 = !{!"%argv.addr <- \22Type is not supported: i8**\22"}
!86 = !{!"%j <- DiscreteDistribution(supp = -1000:1000)"}
!87 = !{!"%e <- DiscreteDistribution(supp = -1000:1000)"}
!88 = !{!"%e1 <- DiscreteDistribution(supp = -1000:1000)"}
!89 = !{!"%retval <- 0"}
!90 = !DILocalVariable(name: "argc", arg: 1, scope: !77, file: !1, line: 21, type: !10)
!91 = !DILocation(line: 21, column: 14, scope: !77)
!92 = !{!"%argv.addr <- %argv"}
!93 = !DILocalVariable(name: "argv", arg: 2, scope: !77, file: !1, line: 21, type: !80)
!94 = !DILocation(line: 21, column: 27, scope: !77)
!95 = !DILocalVariable(name: "j", scope: !96, file: !1, line: 22, type: !10)
!96 = distinct !DILexicalBlock(scope: !77, file: !1, line: 22, column: 3)
!97 = !DILocation(line: 22, column: 12, scope: !96)
!98 = !{!"%j <- 0"}
!99 = !DILocalVariable(name: "e", scope: !96, file: !1, line: 22, type: !10)
!100 = !DILocation(line: 22, column: 19, scope: !96)
!101 = !{!"%e <- 100"}
!102 = !DILocation(line: 22, column: 8, scope: !96)
!103 = !{!"%entry%for.cond <- 1.00"}
!104 = !DILocation(line: 22, column: 28, scope: !105)
!105 = distinct !DILexicalBlock(scope: !96, file: !1, line: 22, column: 3)
!106 = !{!"%0 <- %j"}
!107 = !DILocation(line: 22, column: 33, scope: !105)
!108 = !{!"%1 <- %e"}
!109 = !DILocation(line: 22, column: 30, scope: !105)
!110 = !DILocation(line: 22, column: 3, scope: !96)
!111 = !{!"%for.cond%for.end7 <- %cmp; %for.cond%for.body <- 1 - %cmp"}
!112 = !DILocalVariable(name: "i", scope: !113, file: !1, line: 23, type: !10)
!113 = distinct !DILexicalBlock(scope: !114, file: !1, line: 23, column: 5)
!114 = distinct !DILexicalBlock(scope: !105, file: !1, line: 22, column: 41)
!115 = !DILocation(line: 23, column: 14, scope: !113)
!116 = !{!"%i <- 0"}
!117 = !DILocalVariable(name: "e", scope: !113, file: !1, line: 23, type: !10)
!118 = !DILocation(line: 23, column: 21, scope: !113)
!119 = !DILocation(line: 23, column: 30, scope: !113)
!120 = !{!"%2 <- %argv.addr"}
!121 = !{!"%3 <- %arrayidx"}
!122 = !DILocation(line: 23, column: 25, scope: !113)
!123 = !{!"%e1 <- %call"}
!124 = !DILocation(line: 23, column: 10, scope: !113)
!125 = !{!"%for.body%for.cond2 <- 1.00"}
!126 = !DILocation(line: 23, column: 40, scope: !127)
!127 = distinct !DILexicalBlock(scope: !113, file: !1, line: 23, column: 5)
!128 = !{!"%4 <- %i"}
!129 = !DILocation(line: 23, column: 44, scope: !127)
!130 = !{!"%5 <- %e1"}
!131 = !DILocation(line: 23, column: 42, scope: !127)
!132 = !DILocation(line: 23, column: 5, scope: !113)
!133 = !{!"%for.cond2%for.end <- %cmp3; %for.cond2%for.body4 <- 1 - %cmp3"}
!134 = !DILocation(line: 24, column: 16, scope: !135)
!135 = distinct !DILexicalBlock(scope: !127, file: !1, line: 23, column: 52)
!136 = !{!"%6 <- %argc.addr"}
!137 = !DILocation(line: 24, column: 22, scope: !135)
!138 = !{!"%7 <- %i"}
!139 = !DILocation(line: 24, column: 7, scope: !135)
!140 = !DILocation(line: 25, column: 5, scope: !135)
!141 = !{!"%for.body4%for.inc <- 1.00"}
!142 = !DILocation(line: 23, column: 47, scope: !127)
!143 = !{!"%8 <- %i"}
!144 = !{!"%inc <- %8 + 1"}
!145 = !{!"%i <- %inc"}
!146 = !DILocation(line: 23, column: 5, scope: !127)
!147 = distinct !{!147, !132, !148}
!148 = !DILocation(line: 25, column: 5, scope: !113)
!149 = !{!"%for.inc%for.cond2 <- 1.00"}
!150 = !DILocation(line: 26, column: 3, scope: !114)
!151 = !{!"%for.end%for.inc5 <- 1.00"}
!152 = !DILocation(line: 22, column: 36, scope: !105)
!153 = !{!"%9 <- %j"}
!154 = !{!"%inc6 <- %9 + 1"}
!155 = !{!"%j <- %inc6"}
!156 = !DILocation(line: 22, column: 3, scope: !105)
!157 = distinct !{!157, !110, !158}
!158 = !DILocation(line: 26, column: 3, scope: !96)
!159 = !{!"%for.inc5%for.cond <- 1.00"}
!160 = !DILocation(line: 27, column: 3, scope: !77)
!161 = !{!"%ret <- 0"}
