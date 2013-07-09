//--------------------------------------------------------------------------------------------------------------------
//
//  inspirated by: https://code.google.com/p/blooddy/source/browse/trunk/blooddy_core/src/by/blooddy/core/data/Data.as
//
//--------------------------------------------------------------------------------------------------------------------
package by.rovar.events
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.EventPhase;
import flash.events.IEventDispatcher;

[Exclude(kind="property", name="$parent")]
public class BaseEventDispatcher extends EventDispatcher
{

    public function BaseEventDispatcher(target:IEventDispatcher = null)
    {
        super(target);
    }

    protected function get $parent():BaseEventDispatcher
    {
        return null;
    }

    override public function dispatchEvent(event:Event):Boolean
    {
        var canceled:Boolean;
        if(event.bubbles)
        {
            if(!(event is BaseEvent))
            {
                throw new ArgumentError("only class that extends BaseEvent can bubble");
            }
            else
            {

                var baseEvent:BaseEvent = (event as BaseEvent);
                if(hasEventListener(baseEvent.type))
                {
                    canceled = $dispatchEvent(baseEvent);
                }
                if(!baseEvent.$stopped)
                {
                    var nextParent:BaseEventDispatcher = $parent;
                    while(nextParent)
                    {
                        if(nextParent.hasEventListener(baseEvent.type))
                        baseEvent.$phase = EventPhase.BUBBLING_PHASE;
                        baseEvent.$target = this;
                        CONTAINER.$event = baseEvent;
                        baseEvent.$canceled = canceled;
                        nextParent.$dispatchEvent(CONTAINER);
                        nextParent = nextParent.$parent;
                        if(baseEvent.$stopped)
                        {
                            break;
                        }
                    }
                }
            }
        }
        else
        {
            canceled = super.dispatchEvent(event);
        }
        return canceled;
    }

    private function $dispatchEvent(event:Event):Boolean
    {
        return super.dispatchEvent(event);
    }
}
}

import flash.events.Event;

class EventContainer extends Event
{

    internal var $event:Event;

    private static const TARGET:Object = new Object();

    public function EventContainer()
    {
        super('', true);
    }

    override public function clone():Event
    {
        return $event;
    }


    override public function get target():Object
    {
        return TARGET;
    }
}

internal const CONTAINER:EventContainer = new EventContainer();