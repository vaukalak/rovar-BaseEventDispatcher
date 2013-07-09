package by.rovar.events
{
import flash.events.Event;

public class BaseEvent extends Event
{

    internal var $target:Object;
    internal var $stopped:Boolean;
    internal var $phase:uint;
    public var $canceled:Boolean;

    public function BaseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }


    override public function get eventPhase():uint
    {
        return $phase;
    }

    override public function stopImmediatePropagation():void
    {
        super.stopImmediatePropagation();
        $stopped = true;
    }


    override public function clone():Event
    {
        return new BaseEvent(type, bubbles, cancelable);
    }

    override public function stopPropagation():void
    {
        super.stopPropagation();
        $stopped = true;
    }

    override public function get target():Object
    {
        return $target || super.target;
    }
}
}
