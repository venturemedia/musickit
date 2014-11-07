//  Copyright (c) 2014 Venture Media Labs. All rights reserved.

#import "VMKGeometry.h"
#import "VMKLyricLayer.h"


@implementation VMKLyricLayer

- (instancetype)initWithLyricGeometry:(const mxml::LyricGeometry*)lyricGeometry {
    return [super initWithGeometry:lyricGeometry];
}

- (void)setup {
    [super setup];

    _textLayer = [CATextLayer layer];
    _textLayer.foregroundColor = self.foregroundColor;
    _textLayer.backgroundColor = self.backgroundColor;
    _textLayer.alignmentMode = kCAAlignmentCenter;
    _textLayer.contentsScale = VMKScreenScale();
    [self addSublayer:_textLayer];
}

- (void)setForegroundColor:(CGColorRef)foregroundColor {
    [super setForegroundColor:foregroundColor];
    _textLayer.foregroundColor = foregroundColor;
}

- (const mxml::LyricGeometry*)lyricGeometry {
    return static_cast<const mxml::LyricGeometry*>(self.geometry);
}

- (void)setLyricGeometry:(const mxml::LyricGeometry*)lyricGeometry {
    self.geometry = lyricGeometry;
}

- (void)setGeometry:(const mxml::Geometry*)geometry {
    [super setGeometry:geometry];

    const mxml::dom::Lyric& lyric = self.lyricGeometry->lyric();
    _textLayer.font = (CFTypeRef)@"Baskerville";
    _textLayer.fontSize = 20;

    NSString* string  = [NSString stringWithUTF8String:lyric.text().c_str()];

    mxml::dom::Syllabic::Type type = lyric.syllabic().value().type();
    if (type == mxml::dom::Syllabic::Begin || type == mxml::dom::Syllabic::Middle)
        string = [string stringByAppendingString:@" - "];
    _textLayer.string = string;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    CGSize size = self.bounds.size;
    _textLayer.frame = CGRectMake(0, 0, size.width, size.height);
}

@end
