/*
 * taken from R Core: /src/library/stats/src/init.c rev72233
 * with slight modifications by P. Ruckdeschel 2017-04-20
 */  

 /*
 *  R : A Computer Language for Statistical Data Analysis
 *  Copyright (C) 2001-2017   The R Core Team.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, a copy is available at
 *  https://www.R-project.org/Licenses/
 */

#include <stdlib.h>
#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>
#include "distr.h"

#define CALLDEF(name, n)  {#name, (DL_FUNC) &name, n}


static const R_CallMethodDef R_CallDef[] = {
    CALLDEF(pSmirnov2x, 3),
    CALLDEF(pKolmogorov2x, 2),
    CALLDEF(pKS2, 2),
    {NULL, NULL, 0}
};

void attribute_visible R_init_distr(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, R_CallDef, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    R_forceSymbols(dll, TRUE);

}
