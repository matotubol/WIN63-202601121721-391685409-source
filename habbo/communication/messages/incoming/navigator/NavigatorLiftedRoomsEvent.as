package package_25
{
   import com.sulake.core.communication.messages.MessageEvent;
   import package_15.NavigatorLiftedRoomsEventParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorLiftedRoomsEvent extends MessageEvent
   {
      
      public function NavigatorLiftedRoomsEvent(param1:Function)
      {
         super(param1,NavigatorLiftedRoomsEventParser);
      }
      
      public function getParser() : NavigatorLiftedRoomsEventParser
      {
         return parser as NavigatorLiftedRoomsEventParser;
      }
   }
}

