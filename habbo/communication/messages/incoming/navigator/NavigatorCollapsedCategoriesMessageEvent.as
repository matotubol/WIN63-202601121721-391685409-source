package package_25
{
   import com.sulake.core.communication.messages.MessageEvent;
   import package_15.NavigatorCollapsedCategoriesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorCollapsedCategoriesMessageEvent extends MessageEvent
   {
      
      public function NavigatorCollapsedCategoriesMessageEvent(param1:Function)
      {
         super(param1,NavigatorCollapsedCategoriesMessageEventParser);
      }
      
      public function getParser() : NavigatorCollapsedCategoriesMessageEventParser
      {
         return parser as NavigatorCollapsedCategoriesMessageEventParser;
      }
   }
}

