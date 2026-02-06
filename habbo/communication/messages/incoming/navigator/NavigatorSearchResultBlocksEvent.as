package package_25
{
   import com.sulake.core.communication.messages.MessageEvent;
   import package_15.NavigatorSearchResultBlocksEventParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSearchResultBlocksEvent extends MessageEvent
   {
      
      public function NavigatorSearchResultBlocksEvent(param1:Function)
      {
         super(param1,NavigatorSearchResultBlocksEventParser);
      }
      
      public function getParser() : NavigatorSearchResultBlocksEventParser
      {
         return parser as NavigatorSearchResultBlocksEventParser;
      }
   }
}

