; ModuleID = 'test/c/09-data_access_bug.ll'
source_filename = "test/c/09-data_access_bug.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @get_sign() #0 !dbg !7 {
entry:
  %p = alloca i32*, align 8, !store !11
  %c = alloca i32, align 4, !store !12
  call void @llvm.dbg.declare(metadata i32** %p, metadata !13, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %c, metadata !16, metadata !DIExpression()), !dbg !17
  %call = call noalias i8* @malloc(i64 4) #3, !dbg !18
  %0 = bitcast i8* %call to i32*, !dbg !18
  store i32* %0, i32** %p, align 8, !dbg !19, !store !20
  %1 = load i32*, i32** %p, align 8, !dbg !21, !store !22
  store i32 5, i32* %1, align 4, !dbg !23, !store !24
  %2 = load i32*, i32** %p, align 8, !dbg !25, !store !26
  %3 = load i32, i32* %2, align 4, !dbg !27, !store !28
  %add = add nsw i32 %3, 7, !dbg !29, !store !30
  store i32 %add, i32* %c, align 4, !dbg !31, !store !32
  %4 = load i32*, i32** %p, align 8, !dbg !33, !store !34
  %5 = bitcast i32* %4 to i8*, !dbg !33
  call void @free(i8* %5) #3, !dbg !35
  %6 = load i32, i32* %c, align 4, !dbg !36, !store !37
  ret i32 %6, !dbg !38, !store !39
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4, !store !41
  store i32 0, i32* %retval, align 4, !store !42
  %call = call i32 @get_sign(), !dbg !43
  ret i32 %call, !dbg !44, !store !45
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test/c/09-data_access_bug.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!7 = distinct !DISubprogram(name: "get_sign", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!"%p <- DiscreteDistribution(supp = -1000:1000)"}
!12 = !{!"%c <- DiscreteDistribution(supp = -1000:1000)"}
!13 = !DILocalVariable(name: "p", scope: !7, file: !1, line: 4, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!15 = !DILocation(line: 4, column: 8, scope: !7)
!16 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 4, type: !10)
!17 = !DILocation(line: 4, column: 11, scope: !7)
!18 = !DILocation(line: 5, column: 7, scope: !7)
!19 = !DILocation(line: 5, column: 5, scope: !7)
!20 = !{!"%p <- %0"}
!21 = !DILocation(line: 6, column: 4, scope: !7)
!22 = !{!"%1 <- %p"}
!23 = !DILocation(line: 6, column: 6, scope: !7)
!24 = !{!"%1 <- 5"}
!25 = !DILocation(line: 7, column: 8, scope: !7)
!26 = !{!"%2 <- %p"}
!27 = !DILocation(line: 7, column: 7, scope: !7)
!28 = !{!"%3 <- %2"}
!29 = !DILocation(line: 7, column: 10, scope: !7)
!30 = !{!"%add <- %3 + 7"}
!31 = !DILocation(line: 7, column: 5, scope: !7)
!32 = !{!"%c <- %add"}
!33 = !DILocation(line: 8, column: 8, scope: !7)
!34 = !{!"%4 <- %p"}
!35 = !DILocation(line: 8, column: 3, scope: !7)
!36 = !DILocation(line: 9, column: 10, scope: !7)
!37 = !{!"%6 <- %c"}
!38 = !DILocation(line: 9, column: 3, scope: !7)
!39 = !{!"%ret <- %6"}
!40 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !8, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!41 = !{!"%retval <- DiscreteDistribution(supp = -1000:1000)"}
!42 = !{!"%retval <- 0"}
!43 = !DILocation(line: 12, column: 21, scope: !40)
!44 = !DILocation(line: 12, column: 14, scope: !40)
!45 = !{!"%ret <- %call"}
