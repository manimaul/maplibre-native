#import <XCTest/XCTest.h>

#import <Mapbox.h>
#import "MLNSource_Private.h"

#include <mbgl/style/source.hpp>

@interface MLNTileSourceTests : XCTestCase
@end

@implementation MLNTileSourceTests

- (void)testOversampleMissingTilesDefaultsToNoOnVectorTileSource {
  MLNVectorTileSource *source =
      [[MLNVectorTileSource alloc] initWithIdentifier:@"vector"
                                     tileURLTemplates:@[ @"mbtiles:///tmp/sparse.mbtiles" ]
                                              options:nil];
  XCTAssertFalse(source.oversampleMissingTiles);
  XCTAssertFalse(source.rawSource->getOversampleMissingTiles());
}

- (void)testOversampleMissingTilesRoundTripsOnVectorTileSource {
  MLNVectorTileSource *source =
      [[MLNVectorTileSource alloc] initWithIdentifier:@"vector"
                                     tileURLTemplates:@[ @"mbtiles:///tmp/sparse.mbtiles" ]
                                              options:nil];

  source.oversampleMissingTiles = YES;
  XCTAssertTrue(source.oversampleMissingTiles);
  XCTAssertTrue(source.rawSource->getOversampleMissingTiles());

  source.oversampleMissingTiles = NO;
  XCTAssertFalse(source.oversampleMissingTiles);
  XCTAssertFalse(source.rawSource->getOversampleMissingTiles());
}

- (void)testOversampleMissingTilesOnRasterTileSource {
  MLNRasterTileSource *source =
      [[MLNRasterTileSource alloc] initWithIdentifier:@"raster"
                                     tileURLTemplates:@[ @"mbtiles:///tmp/sparse.mbtiles" ]
                                              options:nil];
  XCTAssertFalse(source.oversampleMissingTiles);

  source.oversampleMissingTiles = YES;
  XCTAssertTrue(source.oversampleMissingTiles);
  XCTAssertTrue(source.rawSource->getOversampleMissingTiles());
}

- (void)testOversampleMissingTilesOnRasterDEMSource {
  MLNRasterDEMSource *source =
      [[MLNRasterDEMSource alloc] initWithIdentifier:@"dem"
                                    tileURLTemplates:@[ @"mbtiles:///tmp/sparse.mbtiles" ]
                                             options:nil];
  XCTAssertFalse(source.oversampleMissingTiles);

  source.oversampleMissingTiles = YES;
  XCTAssertTrue(source.oversampleMissingTiles);
  XCTAssertTrue(source.rawSource->getOversampleMissingTiles());
}

@end
