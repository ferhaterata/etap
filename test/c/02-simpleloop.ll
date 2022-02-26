; ModuleID = 'test/c/02-simpleloop.ll'
source_filename = "test/c/02-simpleloop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"Truey\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"Falsey\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @profiled(i32 %argc, i32 %i) #0 !dbg !7 {
entry:
  %argc.addr = alloca i32, align 4
  %i.addr = alloca i32, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !11, metadata !DIExpression()), !dbg !12
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32, i32* %i.addr, align 4, !dbg !15
  %1 = load i32, i32* %argc.addr, align 4, !dbg !17
  %add = add nsw i32 %0, %1, !dbg !18
  %rem = srem i32 %add, 3, !dbg !19
  %tobool = icmp ne i32 %rem, 0, !dbg !19
  br i1 %tobool, label %if.then, label %if.else, !dbg !20

if.then:                                          ; preds = %entry
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0)), !dbg !21
  br label %if.end, !dbg !23

if.else:                                          ; preds = %entry
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0)), !dbg !24
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void, !dbg !26
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %e = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !33, metadata !DIExpression()), !dbg !34
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata i32* %i, metadata !37, metadata !DIExpression()), !dbg !39
  store i32 0, i32* %i, align 4, !dbg !39
  call void @llvm.dbg.declare(metadata i32* %e, metadata !40, metadata !DIExpression()), !dbg !41
  %0 = load i8**, i8*** %argv.addr, align 8, !dbg !42
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1, !dbg !42
  %1 = load i8*, i8** %arrayidx, align 8, !dbg !42
  %call = call i32 @atoi(i8* %1) #4, !dbg !43
  store i32 %call, i32* %e, align 4, !dbg !41
  br label %for.cond, !dbg !44

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4, !dbg !45
  %3 = load i32, i32* %e, align 4, !dbg !47
  %cmp = icmp slt i32 %2, %3, !dbg !48
  br i1 %cmp, label %for.body, label %for.end, !dbg !49

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %argc.addr, align 4, !dbg !50
  %5 = load i32, i32* %i, align 4, !dbg !52
  call void @profiled(i32 %4, i32 %5), !dbg !53
  br label %for.inc, !dbg !54

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !55
  %inc = add nsw i32 %6, 1, !dbg !55
  store i32 %inc, i32* %i, align 4, !dbg !55
  br label %for.cond, !dbg !56, !llvm.loop !57

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !59
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
!1 = !DIFile(filename: "test/c/02-simpleloop.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"Ubuntu clang version 11.0.1-++20201103062930+ef4ffcafbb2-1~exp1~20201103053545.129"}
!7 = distinct !DISubprogram(name: "profiled", scope: !1, file: !1, line: 4, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "argc", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!12 = !DILocation(line: 4, column: 19, scope: !7)
!13 = !DILocalVariable(name: "i", arg: 2, scope: !7, file: !1, line: 4, type: !10)
!14 = !DILocation(line: 4, column: 29, scope: !7)
!15 = !DILocation(line: 5, column: 8, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !1, line: 5, column: 7)
!17 = !DILocation(line: 5, column: 12, scope: !16)
!18 = !DILocation(line: 5, column: 10, scope: !16)
!19 = !DILocation(line: 5, column: 18, scope: !16)
!20 = !DILocation(line: 5, column: 7, scope: !7)
!21 = !DILocation(line: 6, column: 5, scope: !22)
!22 = distinct !DILexicalBlock(scope: !16, file: !1, line: 5, column: 23)
!23 = !DILocation(line: 7, column: 3, scope: !22)
!24 = !DILocation(line: 8, column: 5, scope: !25)
!25 = distinct !DILexicalBlock(scope: !16, file: !1, line: 7, column: 10)
!26 = !DILocation(line: 10, column: 1, scope: !7)
!27 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !28, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{!10, !10, !30}
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!33 = !DILocalVariable(name: "argc", arg: 1, scope: !27, file: !1, line: 12, type: !10)
!34 = !DILocation(line: 12, column: 14, scope: !27)
!35 = !DILocalVariable(name: "argv", arg: 2, scope: !27, file: !1, line: 12, type: !30)
!36 = !DILocation(line: 12, column: 27, scope: !27)
!37 = !DILocalVariable(name: "i", scope: !38, file: !1, line: 13, type: !10)
!38 = distinct !DILexicalBlock(scope: !27, file: !1, line: 13, column: 3)
!39 = !DILocation(line: 13, column: 12, scope: !38)
!40 = !DILocalVariable(name: "e", scope: !38, file: !1, line: 13, type: !10)
!41 = !DILocation(line: 13, column: 19, scope: !38)
!42 = !DILocation(line: 13, column: 28, scope: !38)
!43 = !DILocation(line: 13, column: 23, scope: !38)
!44 = !DILocation(line: 13, column: 8, scope: !38)
!45 = !DILocation(line: 13, column: 38, scope: !46)
!46 = distinct !DILexicalBlock(scope: !38, file: !1, line: 13, column: 3)
!47 = !DILocation(line: 13, column: 42, scope: !46)
!48 = !DILocation(line: 13, column: 40, scope: !46)
!49 = !DILocation(line: 13, column: 3, scope: !38)
!50 = !DILocation(line: 14, column: 14, scope: !51)
!51 = distinct !DILexicalBlock(scope: !46, file: !1, line: 13, column: 50)
!52 = !DILocation(line: 14, column: 20, scope: !51)
!53 = !DILocation(line: 14, column: 5, scope: !51)
!54 = !DILocation(line: 15, column: 3, scope: !51)
!55 = !DILocation(line: 13, column: 45, scope: !46)
!56 = !DILocation(line: 13, column: 3, scope: !46)
!57 = distinct !{!57, !49, !58}
!58 = !DILocation(line: 15, column: 3, scope: !38)
!59 = !DILocation(line: 16, column: 3, scope: !27)
