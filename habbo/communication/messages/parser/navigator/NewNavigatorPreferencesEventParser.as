package package_15
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NewNavigatorPreferencesEventParser implements IMessageParser
   {
      
      private var var_2768:int;
      
      private var var_2850:int;
      
      private var _windowWidth:int;
      
      private var var_3234:int;
      
      private var var_3148:Boolean;
      
      private var var_2978:int;
      
      public function NewNavigatorPreferencesEventParser()
      {
         super();
      }
      
      public function get windowX() : int
      {
         return var_2768;
      }
      
      public function get windowY() : int
      {
         return var_2850;
      }
      
      public function get windowWidth() : int
      {
         return _windowWidth;
      }
      
      public function get windowHeight() : int
      {
         return var_3234;
      }
      
      public function get leftPaneHidden() : Boolean
      {
         return var_3148;
      }
      
      public function get resultsMode() : int
      {
         return var_2978;
      }
      
      public function flush() : Boolean
      {
         var_2768 = 0;
         var_2850 = 0;
         _windowWidth = 0;
         var_3234 = 0;
         var_3148 = false;
         var_2978 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2768 = param1.readInteger();
         var_2850 = param1.readInteger();
         _windowWidth = param1.readInteger();
         var_3234 = param1.readInteger();
         var_3148 = param1.readBoolean();
         var_2978 = param1.readInteger();
         return true;
      }
   }
}

