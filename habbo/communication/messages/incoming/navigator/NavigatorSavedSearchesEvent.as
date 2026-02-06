package package_25
{
   import com.sulake.core.communication.messages.MessageEvent;
   import package_15.NavigatorSavedSearchesEventParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSavedSearchesEvent extends MessageEvent
   {
      
      public function NavigatorSavedSearchesEvent(param1:Function)
      {
         super(param1,NavigatorSavedSearchesEventParser);
      }
      
      public function getParser() : NavigatorSavedSearchesEventParser
      {
         return parser as NavigatorSavedSearchesEventParser;
      }
   }
}

