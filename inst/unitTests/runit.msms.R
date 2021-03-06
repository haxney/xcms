test.xcmsRawms1 <- function() {

    filename <- system.file('microtofq/MM14.mzdata', package = "msdata")

    ## This file has no MS/MS data at all, but should not fail
    x1 <- xcmsRaw(filename, includeMSn=TRUE)

}

test.xcmsRawms123 <- function() {

    filename <- system.file('iontrap/extracted.mzData', package = "msdata")

    x1 <- xcmsRaw(filename, includeMSn=TRUE)
    x2 <- xcmsRaw(filename, includeMSn=TRUE, mslevel=2)
    x3 <- xcmsRaw(filename, includeMSn=TRUE, mslevel=3)

    checkTrue(length(x1@env$msnMz) == length(x2@env$mz) + length(x3@env$mz))

    checkTrue(all(x1@msnLevel[1:6]==2))

    checkTrue(all(x1@msnScanindex[1:6] == x2@scanindex[1:6]))

    checkEqualsNumeric(nrow(getMsnScan(x1, scan=1)), 278)

    ## This would fail, since mslevel=2 above seems to use split(),
    ## which does drop MSn information ?
    ## checkEqualsNumeric(nrow(xcms:::getMsnScan(x2, scan=1)), 278)

}

test.xcmsSetms2mf <- function() {

    filename <- system.file('iontrap/extracted.mzData', package = "msdata")
    xs2 <- xcmsSet(filename, snthresh=4, mslevel=2)
}

test.xcmsSetms2cw <- function() {

    filename <- system.file('iontrap/extracted.mzData', package = "msdata")
    xs2 <- xcmsSet(filename, method="centWave", mslevel=2)

}
