; ModuleID = './.llvm/input.ll'
source_filename = "./input/array_struct.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i8*, double }

@bar = dso_local global [100 x %struct.Foo] zeroinitializer, align 16, !dbg !0
@.str = private unnamed_addr constant [2 x i8] c"5\00", align 1
@foo = dso_local global %struct.Foo zeroinitializer, align 8, !dbg !6

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @funct1() #0 !dbg !25 {
entry:
  %b_ptr = alloca i8**, align 8
  store double 2.000000e-01, double* getelementptr inbounds ([100 x %struct.Foo], [100 x %struct.Foo]* @bar, i64 0, i64 17, i32 2), align 8, !dbg !28
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8** getelementptr inbounds (%struct.Foo, %struct.Foo* @foo, i32 0, i32 1), align 8, !dbg !29
  call void @llvm.dbg.declare(metadata i8*** %b_ptr, metadata !30, metadata !DIExpression()), !dbg !32
  store i8** getelementptr inbounds (%struct.Foo, %struct.Foo* @foo, i32 0, i32 1), i8*** %b_ptr, align 8, !dbg !32
  ret void, !dbg !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32* @funct2(%struct.Foo* %F) #0 !dbg !34 {
entry:
  %F.addr = alloca %struct.Foo*, align 8
  store %struct.Foo* %F, %struct.Foo** %F.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.Foo** %F.addr, metadata !39, metadata !DIExpression()), !dbg !40
  %0 = load %struct.Foo*, %struct.Foo** %F.addr, align 8, !dbg !41
  %a = getelementptr inbounds %struct.Foo, %struct.Foo* %0, i32 0, i32 0, !dbg !42
  store i32 5, i32* %a, align 8, !dbg !43
  %1 = load %struct.Foo*, %struct.Foo** %F.addr, align 8, !dbg !44
  %a1 = getelementptr inbounds %struct.Foo, %struct.Foo* %1, i32 0, i32 0, !dbg !45
  ret i32* %a1, !dbg !46
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!21, !22, !23}
!llvm.ident = !{!24}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "bar", scope: !2, file: !8, line: 14, type: !18, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "input/array_struct.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!4 = !{}
!5 = !{!6, !0}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "foo", scope: !2, file: !8, line: 13, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "./input/array_struct.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Foo", file: !8, line: 7, size: 192, elements: !10)
!10 = !{!11, !13, !16}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !9, file: !8, line: 8, baseType: !12, size: 32)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !9, file: !8, line: 9, baseType: !14, size: 64, offset: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !9, file: !8, line: 10, baseType: !17, size: 64, offset: 128)
!17 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 19200, elements: !19)
!19 = !{!20}
!20 = !DISubrange(count: 100)
!21 = !{i32 7, !"Dwarf Version", i32 4}
!22 = !{i32 2, !"Debug Info Version", i32 3}
!23 = !{i32 1, !"wchar_size", i32 4}
!24 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!25 = distinct !DISubprogram(name: "funct1", scope: !8, file: !8, line: 16, type: !26, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{null}
!28 = !DILocation(line: 17, column: 13, scope: !25)
!29 = !DILocation(line: 18, column: 9, scope: !25)
!30 = !DILocalVariable(name: "b_ptr", scope: !25, file: !8, line: 19, type: !31)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!32 = !DILocation(line: 19, column: 10, scope: !25)
!33 = !DILocation(line: 20, column: 1, scope: !25)
!34 = distinct !DISubprogram(name: "funct2", scope: !8, file: !8, line: 22, type: !35, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!35 = !DISubroutineType(types: !36)
!36 = !{!37, !38}
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!39 = !DILocalVariable(name: "F", arg: 1, scope: !34, file: !8, line: 22, type: !38)
!40 = !DILocation(line: 22, column: 25, scope: !34)
!41 = !DILocation(line: 23, column: 3, scope: !34)
!42 = !DILocation(line: 23, column: 6, scope: !34)
!43 = !DILocation(line: 23, column: 8, scope: !34)
!44 = !DILocation(line: 24, column: 11, scope: !34)
!45 = !DILocation(line: 24, column: 14, scope: !34)
!46 = !DILocation(line: 24, column: 3, scope: !34)
