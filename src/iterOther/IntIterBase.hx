package iterOther;
@:access(IntIterator.min, IntIterator.max)
class IntIterBase {
	public var start:Int;
	public var end:Int;
	public var other:Int;
	public function new(min_:Int, max_:Int) {
		start = min_;
		end = max_;
	}
}

@:transitive
@:access(IntIterator.min, IntIterator.max)
abstract Steps(IntIterBase) from IntIterBase {
  public var step( never, set ): Int;
  inline function set_step(v:Int):Int{
		this.other = v;
    return v;
  }
  public inline function new(min:Int, max:Int) {
		this = new IntIterBase(min, max);
	}
  @:from
	static inline public function fromIterator(ii:IntIterator):Steps {
		return new Steps(ii.min, ii.max);
	}
	@:to
	function toIterStart():Steps {
		return new Steps(this.start, this.end);
	}
  public inline function hasNext() return this.start < this.end;
  public inline function next() return ( this.start += this.other ) - this.other;
}

@:transitive
@:access(IntIterator.min, IntIterator.max)
abstract Forwards(IntIterBase) from IntIterBase {
	public inline function new(min:Int, max:Int) {
		this = new IntIterBase(min, max);
		this.other = min;
	}
  @:from
	static inline public function fromIterator(ii:IntIterator):Forwards {
		return new Forwards(ii.min, ii.max);
	}
	@:to
	function toIterStart():Forwards {
		return new Forwards(this.start, this.end);
	}
  public inline function hasNext() {
		return this.end > this.start;
	}
	public inline function next() {
		return (this.start++);
	}
	public inline function reset() {
		this.start = this.other;
  }
  @:to
  function toBackwards():Backwards {
    reset();
		return new Backwards(this.start, this.end);
  }
  @:to
  function toSteps():Steps {
    reset();
		return new Steps(this.start, this.end);
  }
}
@:transitive
@:access(IntIterator.min, IntIterator.max)
abstract Backwards(IntIterBase) from IntIterBase {
	public inline function new(min:Int, max:Int) {
		this = new IntIterBase(min, max);
		this.other = max;
	}
	@:from
	static inline public function fromIterator(ii:IntIterator):Backwards {
		return new Backwards(ii.min, ii.max);
	}
	@:to
	function toIterStart():Backwards {
		return new Backwards(this.start, this.end);
	}
	public inline function hasNext() {
		return this.end > this.start;
	}
	public inline function next() {
		return (this.end-- -1);
	}
	public inline function reset() {
		this.end = this.other;
	}
  @:to
  function toForwards():Forwards {
    reset();
		return new Forwards(this.start, this.end);
  }
  @:to
  function toSteps():Steps {
    reset();
    return new Steps(this.start, this.end);
  }
}
