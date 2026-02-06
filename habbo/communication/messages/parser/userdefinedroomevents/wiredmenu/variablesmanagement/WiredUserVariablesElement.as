package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredUserVariablesElement
   {
      
      private var var_3566:int;
      
      private var var_4152:int;
      
      private var var_4074:String;
      
      private var var_4310:WiredVariableStorageParameter;
      
      public function WiredUserVariablesElement(param1:IMessageDataWrapper)
      {
         super();
         var_3566 = param1.readInteger();
         var_4152 = param1.readInteger();
         var_4074 = param1.readString();
         var_4310 = new WiredVariableStorageParameter(param1);
      }
      
      public function get entityType() : int
      {
         return var_3566;
      }
      
      public function get entityId() : int
      {
         return var_4152;
      }
      
      public function get entityName() : String
      {
         return var_4074;
      }
      
      public function get storage() : WiredVariableStorageParameter
      {
         return var_4310;
      }
   }
}

