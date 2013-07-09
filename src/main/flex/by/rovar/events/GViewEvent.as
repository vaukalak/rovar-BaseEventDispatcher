/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 6/30/13
 * Time: 5:19 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.events
{
public class GViewEvent extends BaseEvent
{
    public static const ADDED:String = "added";
    public static const ADDED_TO_STAGE:String = "addedToStage";
    public static const REMOVED:String = "removed";
    public static const REMOVED_FROM_STAGE:String = "removedFromStage";

    public function GViewEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }
}
}
