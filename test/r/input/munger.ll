; ModuleID = './.llvm/input.ll'
source_filename = "./input/munger.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.munger_struct = type { i32, i32 }

; Function Attrs: alwaysinline nounwind uwtable
define dso_local void @munge(%struct.munger_struct* %P) #0 !dbg !7 {
entry:
  call void @llvm.dbg.value(metadata %struct.munger_struct* %P, metadata !17, metadata !DIExpression()), !dbg !18
  %arrayidx = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %P, i64 1, !dbg !19
  %f1 = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %arrayidx, i32 0, i32 0, !dbg !20
  %0 = load i32, i32* %f1, align 4, !dbg !20
  %arrayidx1 = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %P, i64 2, !dbg !21
  %f2 = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %arrayidx1, i32 0, i32 1, !dbg !22
  %1 = load i32, i32* %f2, align 4, !dbg !22
  %add = add nsw i32 %0, %1, !dbg !23
  %arrayidx2 = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %P, i64 0, !dbg !24
  %f13 = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %arrayidx2, i32 0, i32 0, !dbg !25
  store i32 %add, i32* %f13, align 4, !dbg !26
  ret void, !dbg !27
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @munger() #2 !dbg !28 {
entry:
  %P.addr.i = alloca %struct.munger_struct*, align 8
  %Array = alloca [3 x %struct.munger_struct], align 16
  call void @llvm.dbg.declare(metadata [3 x %struct.munger_struct]* %Array, metadata !31, metadata !DIExpression()), !dbg !35
  %arraydecay = getelementptr inbounds [3 x %struct.munger_struct], [3 x %struct.munger_struct]* %Array, i64 0, i64 0, !dbg !36
  store %struct.munger_struct* %arraydecay, %struct.munger_struct** %P.addr.i, align 8
  call void @llvm.dbg.declare(metadata %struct.munger_struct** %P.addr.i, metadata !17, metadata !DIExpression()), !dbg !37
  %0 = load %struct.munger_struct*, %struct.munger_struct** %P.addr.i, align 8, !dbg !39
  %arrayidx.i = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %0, i64 1, !dbg !39
  %f1.i = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %arrayidx.i, i32 0, i32 0, !dbg !40
  %1 = load i32, i32* %f1.i, align 4, !dbg !40
  %2 = load %struct.munger_struct*, %struct.munger_struct** %P.addr.i, align 8, !dbg !41
  %arrayidx1.i = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %2, i64 2, !dbg !41
  %f2.i = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %arrayidx1.i, i32 0, i32 1, !dbg !42
  %3 = load i32, i32* %f2.i, align 4, !dbg !42
  %add.i = add nsw i32 %1, %3, !dbg !43
  %4 = load %struct.munger_struct*, %struct.munger_struct** %P.addr.i, align 8, !dbg !44
  %f13.i = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %4, i32 0, i32 0, !dbg !45
  store i32 %add.i, i32* %f13.i, align 4, !dbg !46
  %arrayidx = getelementptr inbounds [3 x %struct.munger_struct], [3 x %struct.munger_struct]* %Array, i64 0, i64 0, !dbg !47
  %f1 = getelementptr inbounds %struct.munger_struct, %struct.munger_struct* %arrayidx, i32 0, i32 0, !dbg !48
  %5 = load i32, i32* %f1, align 16, !dbg !48
  ret i32 %5, !dbg !49
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "input/munger.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!7 = distinct !DISubprogram(name: "munge", scope: !8, file: !8, line: 12, type: !9, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "./input/munger.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "munger_struct", file: !8, line: 7, size: 64, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "f1", scope: !12, file: !8, line: 8, baseType: !15, size: 32)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "f2", scope: !12, file: !8, line: 9, baseType: !15, size: 32, offset: 32)
!17 = !DILocalVariable(name: "P", arg: 1, scope: !7, file: !8, line: 12, type: !11)
!18 = !DILocation(line: 0, scope: !7)
!19 = !DILocation(line: 13, column: 13, scope: !7)
!20 = !DILocation(line: 13, column: 18, scope: !7)
!21 = !DILocation(line: 13, column: 23, scope: !7)
!22 = !DILocation(line: 13, column: 28, scope: !7)
!23 = !DILocation(line: 13, column: 21, scope: !7)
!24 = !DILocation(line: 13, column: 3, scope: !7)
!25 = !DILocation(line: 13, column: 8, scope: !7)
!26 = !DILocation(line: 13, column: 11, scope: !7)
!27 = !DILocation(line: 14, column: 1, scope: !7)
!28 = distinct !DISubprogram(name: "munger", scope: !8, file: !8, line: 16, type: !29, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!15}
!31 = !DILocalVariable(name: "Array", scope: !28, file: !8, line: 17, type: !32)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 192, elements: !33)
!33 = !{!34}
!34 = !DISubrange(count: 3)
!35 = !DILocation(line: 17, column: 24, scope: !28)
!36 = !DILocation(line: 18, column: 9, scope: !28)
!37 = !DILocation(line: 12, column: 65, scope: !7, inlinedAt: !38)
!38 = distinct !DILocation(line: 18, column: 3, scope: !28)
!39 = !DILocation(line: 13, column: 13, scope: !7, inlinedAt: !38)
!40 = !DILocation(line: 13, column: 18, scope: !7, inlinedAt: !38)
!41 = !DILocation(line: 13, column: 23, scope: !7, inlinedAt: !38)
!42 = !DILocation(line: 13, column: 28, scope: !7, inlinedAt: !38)
!43 = !DILocation(line: 13, column: 21, scope: !7, inlinedAt: !38)
!44 = !DILocation(line: 13, column: 3, scope: !7, inlinedAt: !38)
!45 = !DILocation(line: 13, column: 8, scope: !7, inlinedAt: !38)
!46 = !DILocation(line: 13, column: 11, scope: !7, inlinedAt: !38)
!47 = !DILocation(line: 19, column: 10, scope: !28)
!48 = !DILocation(line: 19, column: 19, scope: !28)
!49 = !DILocation(line: 19, column: 3, scope: !28)
