; ModuleID = 'test/c/10-cascadingcalls.ll'
source_filename = "test/c/10-cascadingcalls.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foo() #0 !dbg !7 {
entry:
  ret void, !dbg !10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @bar() #0 !dbg !11 {
entry:
  call void @foo(), !dbg !12
  ret void, !dbg !13
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fez() #0 !dbg !14 {
entry:
  call void @bar(), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !17 {
entry:
  %retval = alloca i32, align 4
  %ii = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @foo(), !dbg !21
  call void @bar(), !dbg !22
  call void @fez(), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %ii, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 0, i32* %ii, align 4, !dbg !25
  store i32 0, i32* %ii, align 4, !dbg !26
  br label %for.cond, !dbg !28

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %ii, align 4, !dbg !29
  %cmp = icmp slt i32 %0, 10, !dbg !31
  br i1 %cmp, label %for.body, label %for.end, !dbg !32

for.body:                                         ; preds = %for.cond
  call void @foo(), !dbg !33
  br label %for.inc, !dbg !33

for.inc:                                          ; preds = %for.body
  %1 = load i32, i32* %ii, align 4, !dbg !34
  %inc = add nsw i32 %1, 1, !dbg !34
  store i32 %inc, i32* %ii, align 4, !dbg !34
  br label %for.cond, !dbg !35, !llvm.loop !36

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !38
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test/c/10-cascadingcalls.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !8, scopeLine: 1, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 1, column: 13, scope: !7)
!11 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 2, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DILocation(line: 2, column: 14, scope: !11)
!13 = !DILocation(line: 2, column: 21, scope: !11)
!14 = distinct !DISubprogram(name: "fez", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DILocation(line: 3, column: 14, scope: !14)
!16 = !DILocation(line: 3, column: 21, scope: !14)
!17 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !18, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{!20}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocation(line: 6, column: 3, scope: !17)
!22 = !DILocation(line: 7, column: 3, scope: !17)
!23 = !DILocation(line: 8, column: 3, scope: !17)
!24 = !DILocalVariable(name: "ii", scope: !17, file: !1, line: 10, type: !20)
!25 = !DILocation(line: 10, column: 7, scope: !17)
!26 = !DILocation(line: 11, column: 11, scope: !27)
!27 = distinct !DILexicalBlock(scope: !17, file: !1, line: 11, column: 3)
!28 = !DILocation(line: 11, column: 8, scope: !27)
!29 = !DILocation(line: 11, column: 16, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 11, column: 3)
!31 = !DILocation(line: 11, column: 19, scope: !30)
!32 = !DILocation(line: 11, column: 3, scope: !27)
!33 = !DILocation(line: 11, column: 31, scope: !30)
!34 = !DILocation(line: 11, column: 27, scope: !30)
!35 = !DILocation(line: 11, column: 3, scope: !30)
!36 = distinct !{!36, !32, !37}
!37 = !DILocation(line: 11, column: 35, scope: !27)
!38 = !DILocation(line: 13, column: 3, scope: !17)
