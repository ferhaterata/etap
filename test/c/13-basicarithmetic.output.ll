; ModuleID = 'test/c/13-basicarithmetic.ll'
source_filename = "test/c/13-basicarithmetic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !7 !store !14 !store !15 {
entry:
  %retval = alloca i32, align 4, !store !16
  %argc.addr = alloca i32, align 4, !store !17
  %argv.addr = alloca i8**, align 8, !store !18
  %a = alloca i32, align 4, !store !19
  %b = alloca i32, align 4, !store !20
  %c = alloca i32, align 4, !store !21
  %d = alloca i32, align 4, !store !22
  %e = alloca i32, align 4, !store !23
  %f = alloca i32, align 4, !store !24
  store i32 0, i32* %retval, align 4, !store !25
  store i32 %argc, i32* %argc.addr, align 4, !store !26
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !27, metadata !DIExpression()), !dbg !28
  store i8** %argv, i8*** %argv.addr, align 8, !store !29
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %a, metadata !32, metadata !DIExpression()), !dbg !33
  %0 = load i8**, i8*** %argv.addr, align 8, !dbg !34, !store !35
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1, !dbg !34
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !34, !store !36
  %call = call i32 @atoi(i8* %1) #3, !dbg !37
  store i32 %call, i32* %a, align 4, !dbg !33, !store !38
  call void @llvm.dbg.declare(metadata i32* %b, metadata !39, metadata !DIExpression()), !dbg !40
  %2 = load i8**, i8*** %argv.addr, align 8, !dbg !41, !store !42
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 2, !dbg !41
  %3 = load i8*, i8** %arrayidx1, align 8, !dbg !41, !store !43
  %call2 = call i32 @atoi(i8* %3) #3, !dbg !44
  store i32 %call2, i32* %b, align 4, !dbg !40, !store !45
  call void @llvm.dbg.declare(metadata i32* %c, metadata !46, metadata !DIExpression()), !dbg !47
  %4 = load i8**, i8*** %argv.addr, align 8, !dbg !48, !store !49
  %arrayidx3 = getelementptr inbounds i8*, i8** %4, i64 3, !dbg !48
  %5 = load i8*, i8** %arrayidx3, align 8, !dbg !48, !store !50
  %call4 = call i32 @atoi(i8* %5) #3, !dbg !51
  store i32 %call4, i32* %c, align 4, !dbg !47, !store !52
  call void @llvm.dbg.declare(metadata i32* %d, metadata !53, metadata !DIExpression()), !dbg !54
  %6 = load i8**, i8*** %argv.addr, align 8, !dbg !55, !store !56
  %arrayidx5 = getelementptr inbounds i8*, i8** %6, i64 4, !dbg !55
  %7 = load i8*, i8** %arrayidx5, align 8, !dbg !55, !store !57
  %call6 = call i32 @atoi(i8* %7) #3, !dbg !58
  store i32 %call6, i32* %d, align 4, !dbg !54, !store !59
  call void @llvm.dbg.declare(metadata i32* %e, metadata !60, metadata !DIExpression()), !dbg !61
  %8 = load i32, i32* %a, align 4, !dbg !62, !store !63
  %9 = load i32, i32* %b, align 4, !dbg !64, !store !65
  %sub = sub nsw i32 %8, %9, !dbg !66, !store !67
  store i32 %sub, i32* %e, align 4, !dbg !61, !store !68
  call void @llvm.dbg.declare(metadata i32* %f, metadata !69, metadata !DIExpression()), !dbg !70
  %10 = load i32, i32* %c, align 4, !dbg !71, !store !72
  %11 = load i32, i32* %d, align 4, !dbg !73, !store !74
  %sub7 = sub nsw i32 %10, %11, !dbg !75, !store !76
  store i32 %sub7, i32* %f, align 4, !dbg !70, !store !77
  %12 = load i32, i32* %e, align 4, !dbg !78, !store !79
  %13 = load i32, i32* %f, align 4, !dbg !80, !store !81
  %sub8 = sub nsw i32 %12, %13, !dbg !82, !store !83
  ret i32 %sub8, !dbg !84, !store !85
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

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
!1 = !DIFile(filename: "test/c/13-basicarithmetic.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !{!"%argc <- DiscreteDistribution(supp = -1000:1000)"}
!15 = !{!"%argv <- \22Type is not supported: i8**\22"}
!16 = !{!"%retval <- DiscreteDistribution(supp = -1000:1000)"}
!17 = !{!"%argc.addr <- DiscreteDistribution(supp = -1000:1000)"}
!18 = !{!"%argv.addr <- \22Type is not supported: i8**\22"}
!19 = !{!"%a <- DiscreteDistribution(supp = -1000:1000)"}
!20 = !{!"%b <- DiscreteDistribution(supp = -1000:1000)"}
!21 = !{!"%c <- DiscreteDistribution(supp = -1000:1000)"}
!22 = !{!"%d <- DiscreteDistribution(supp = -1000:1000)"}
!23 = !{!"%e <- DiscreteDistribution(supp = -1000:1000)"}
!24 = !{!"%f <- DiscreteDistribution(supp = -1000:1000)"}
!25 = !{!"%retval <- 0"}
!26 = !{!"%argc.addr <- %argc"}
!27 = !DILocalVariable(name: "argc", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!28 = !DILocation(line: 3, column: 14, scope: !7)
!29 = !{!"%argv.addr <- %argv"}
!30 = !DILocalVariable(name: "argv", arg: 2, scope: !7, file: !1, line: 3, type: !11)
!31 = !DILocation(line: 3, column: 26, scope: !7)
!32 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 4, type: !10)
!33 = !DILocation(line: 4, column: 7, scope: !7)
!34 = !DILocation(line: 4, column: 16, scope: !7)
!35 = !{!"%0 <- %argv.addr"}
!36 = !{!"%1 <- %arrayidx"}
!37 = !DILocation(line: 4, column: 11, scope: !7)
!38 = !{!"%a <- %call"}
!39 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 4, type: !10)
!40 = !DILocation(line: 4, column: 26, scope: !7)
!41 = !DILocation(line: 4, column: 35, scope: !7)
!42 = !{!"%2 <- %argv.addr"}
!43 = !{!"%3 <- %arrayidx1"}
!44 = !DILocation(line: 4, column: 30, scope: !7)
!45 = !{!"%b <- %call2"}
!46 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 4, type: !10)
!47 = !DILocation(line: 4, column: 45, scope: !7)
!48 = !DILocation(line: 4, column: 54, scope: !7)
!49 = !{!"%4 <- %argv.addr"}
!50 = !{!"%5 <- %arrayidx3"}
!51 = !DILocation(line: 4, column: 49, scope: !7)
!52 = !{!"%c <- %call4"}
!53 = !DILocalVariable(name: "d", scope: !7, file: !1, line: 5, type: !10)
!54 = !DILocation(line: 5, column: 7, scope: !7)
!55 = !DILocation(line: 5, column: 16, scope: !7)
!56 = !{!"%6 <- %argv.addr"}
!57 = !{!"%7 <- %arrayidx5"}
!58 = !DILocation(line: 5, column: 11, scope: !7)
!59 = !{!"%d <- %call6"}
!60 = !DILocalVariable(name: "e", scope: !7, file: !1, line: 7, type: !10)
!61 = !DILocation(line: 7, column: 7, scope: !7)
!62 = !DILocation(line: 7, column: 11, scope: !7)
!63 = !{!"%8 <- %a"}
!64 = !DILocation(line: 7, column: 15, scope: !7)
!65 = !{!"%9 <- %b"}
!66 = !DILocation(line: 7, column: 13, scope: !7)
!67 = !{!"%sub <- %8 - %9"}
!68 = !{!"%e <- %sub"}
!69 = !DILocalVariable(name: "f", scope: !7, file: !1, line: 8, type: !10)
!70 = !DILocation(line: 8, column: 7, scope: !7)
!71 = !DILocation(line: 8, column: 11, scope: !7)
!72 = !{!"%10 <- %c"}
!73 = !DILocation(line: 8, column: 15, scope: !7)
!74 = !{!"%11 <- %d"}
!75 = !DILocation(line: 8, column: 13, scope: !7)
!76 = !{!"%sub7 <- %10 - %11"}
!77 = !{!"%f <- %sub7"}
!78 = !DILocation(line: 10, column: 10, scope: !7)
!79 = !{!"%12 <- %e"}
!80 = !DILocation(line: 10, column: 14, scope: !7)
!81 = !{!"%13 <- %f"}
!82 = !DILocation(line: 10, column: 12, scope: !7)
!83 = !{!"%sub8 <- %12 - %13"}
!84 = !DILocation(line: 10, column: 3, scope: !7)
!85 = !{!"%ret <- %sub8"}
