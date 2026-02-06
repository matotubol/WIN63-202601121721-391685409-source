package package_25
{
   import com.sulake.core.communication.messages.MessageEvent;
   import package_15.NavigatorMetaDataEventParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorMetaDataEvent extends MessageEvent
   {
      
      public function NavigatorMetaDataEvent(param1:Function)
      {
         super(param1,NavigatorMetaDataEventParser);
      }
      
      public function getParser() : NavigatorMetaDataEventParser
      {
         return parser as NavigatorMetaDataEventParser;
      }
   }
}

