package package_25
{
   import com.sulake.core.communication.messages.MessageEvent;
   import package_15.NewNavigatorPreferencesEventParser;
   
   [SecureSWF(rename="true")]
   public class NewNavigatorPreferencesEvent extends MessageEvent
   {
      
      public function NewNavigatorPreferencesEvent(param1:Function)
      {
         super(param1,NewNavigatorPreferencesEventParser);
      }
      
      public function getParser() : NewNavigatorPreferencesEventParser
      {
         return parser as NewNavigatorPreferencesEventParser;
      }
   }
}

