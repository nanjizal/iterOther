package iterOther;

class FloatIterBase {
	public var start:Float;
	public var end:Float;
	public var delta:Float;
	public var isUp:Bool;
  // if you want to iter to last value and clamp to it, useful perhaps on tween.
	public var clampEnd:Bool;

	public function new(start_:Float, end_:Float) {
		start = start_;
		end = end_;
		clampEnd = false;
	}
}

@:forward
abstract F(Float) to Float from Float {
	public inline function new(f:Float) {
		this = f;
	}

	@:op(A...B)
	public static function rangeFloat(a:F, b:F):FloatIterBase {
		return new FloatIterBase(a, b);
	}
}
@:forward
@:transitive
abstract Stepsf(FloatIterBase) {
	public var step(never, set):Float;

	inline function set_step(v:Float):Float {
		this.delta = (this.isUp == true) ? Math.abs(v) : -Math.abs(v);
		return v;
	}

	public inline function new(start:Float, end:Float) {
		this = new FloatIterBase(start, end);
		this.isUp = start < end;
		this.delta = (this.isUp) ? 1 : -1; // sensible default
	}

	@:to
	function toIterStart():Stepsf {
		return new Stepsf(this.start, this.end);
	}

	@:from
	static inline public function fromFloatBase(v:FloatIterBase):Stepsf {
		return new Stepsf(v.start, v.end);
	}

	public inline function hasNext() {
		return if (this.isUp) {
			if (this.clampEnd) {
				this.start < this.end + this.delta;
			} else {
				this.start < this.end;
			}
		} else {
			if (this.clampEnd) {
				this.end + this.delta < this.start;
			} else {
				this.end < this.start;
			}
		}
	}

	public inline function next() {
		var v = (this.start = this.start + this.delta) - this.delta;
		return if (this.clampEnd) {
			if (this.isUp) {
				if (v > this.end) {
					this.end;
				} else {
					v;
				}
			} else {
				if (v < this.end) {
					this.end;
				} else {
					v;
				}
			}
		} else {
			// not clamped just next.
			v;
		}
	}
}
