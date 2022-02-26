; ModuleID = 'test/c/13-basicarithmetic.ll'
source_filename = "test/c/13-basicarithmetic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %f = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !14, metadata !DIExpression()), !dbg !15
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %a, metadata !18, metadata !DIExpression()), !dbg !19
  %0 = load i8**, i8*** %argv.addr, align 8, !dbg !20
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1, !dbg !20
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !20
  %call = call i32 @atoi(i8* %1) #3, !dbg !21
  store i32 %call, i32* %a, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %b, metadata !22, metadata !DIExpression()), !dbg !23
  %2 = load i8**, i8*** %argv.addr, align 8, !dbg !24
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 2, !dbg !24
  %3 = load i8*, i8** %arrayidx1, align 8, !dbg !24
  %call2 = call i32 @atoi(i8* %3) #3, !dbg !25
  store i32 %call2, i32* %b, align 4, !dbg !23
  call void @llvm.dbg.declare(metadata i32* %c, metadata !26, metadata !DIExpression()), !dbg !27
  %4 = load i8**, i8*** %argv.addr, align 8, !dbg !28
  %arrayidx3 = getelementptr inbounds i8*, i8** %4, i64 3, !dbg !28
  %5 = load i8*, i8** %arrayidx3, align 8, !dbg !28
  %call4 = call i32 @atoi(i8* %5) #3, !dbg !29
  store i32 %call4, i32* %c, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata i32* %d, metadata !30, metadata !DIExpression()), !dbg !31
  %6 = load i8**, i8*** %argv.addr, align 8, !dbg !32
  %arrayidx5 = getelementptr inbounds i8*, i8** %6, i64 4, !dbg !32
  %7 = load i8*, i8** %arrayidx5, align 8, !dbg !32
  %call6 = call i32 @atoi(i8* %7) #3, !dbg !33
  store i32 %call6, i32* %d, align 4, !dbg !31
  call void @llvm.dbg.declare(metadata i32* %e, metadata !34, metadata !DIExpression()), !dbg !35
  %8 = load i32, i32* %a, align 4, !dbg !36
  %9 = load i32, i32* %b, align 4, !dbg !37
  %sub = sub nsw i32 %8, %9, !dbg !38
  store i32 %sub, i32* %e, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata i32* %f, metadata !39, metadata !DIExpression()), !dbg !40
  %10 = load i32, i32* %c, align 4, !dbg !41
  %11 = load i32, i32* %d, align 4, !dbg !42
  %sub7 = sub nsw i32 %10, %11, !dbg !43
  store i32 %sub7, i32* %f, align 4, !dbg !40
  %12 = load i32, i32* %e, align 4, !dbg !44
  %13 = load i32, i32* %f, align 4, !dbg !45
  %sub8 = sub nsw i32 %12, %13, !dbg !46
  ret i32 %sub8, !dbg !47
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
!14 = !DILocalVariable(name: "argc", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!15 = !DILocation(line: 3, column: 14, scope: !7)
!16 = !DILocalVariable(name: "argv", arg: 2, scope: !7, file: !1, line: 3, type: !11)
!17 = !DILocation(line: 3, column: 26, scope: !7)
!18 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 4, type: !10)
!19 = !DILocation(line: 4, column: 7, scope: !7)
!20 = !DILocation(line: 4, column: 16, scope: !7)
!21 = !DILocation(line: 4, column: 11, scope: !7)
!22 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 4, type: !10)
!23 = !DILocation(line: 4, column: 26, scope: !7)
!24 = !DILocation(line: 4, column: 35, scope: !7)
!25 = !DILocation(line: 4, column: 30, scope: !7)
!26 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 4, type: !10)
!27 = !DILocation(line: 4, column: 45, scope: !7)
!28 = !DILocation(line: 4, column: 54, scope: !7)
!29 = !DILocation(line: 4, column: 49, scope: !7)
!30 = !DILocalVariable(name: "d", scope: !7, file: !1, line: 5, type: !10)
!31 = !DILocation(line: 5, column: 7, scope: !7)
!32 = !DILocation(line: 5, column: 16, scope: !7)
!33 = !DILocation(line: 5, column: 11, scope: !7)
!34 = !DILocalVariable(name: "e", scope: !7, file: !1, line: 7, type: !10)
!35 = !DILocation(line: 7, column: 7, scope: !7)
!36 = !DILocation(line: 7, column: 11, scope: !7)
!37 = !DILocation(line: 7, column: 15, scope: !7)
!38 = !DILocation(line: 7, column: 13, scope: !7)
!39 = !DILocalVariable(name: "f", scope: !7, file: !1, line: 8, type: !10)
!40 = !DILocation(line: 8, column: 7, scope: !7)
!41 = !DILocation(line: 8, column: 11, scope: !7)
!42 = !DILocation(line: 8, column: 15, scope: !7)
!43 = !DILocation(line: 8, column: 13, scope: !7)
!44 = !DILocation(line: 10, column: 10, scope: !7)
!45 = !DILocation(line: 10, column: 14, scope: !7)
!46 = !DILocation(line: 10, column: 12, scope: !7)
!47 = !DILocation(line: 10, column: 3, scope: !7)
