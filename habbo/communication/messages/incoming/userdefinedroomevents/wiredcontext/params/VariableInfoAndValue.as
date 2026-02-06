package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_189.WiredVariable;
   
   public class VariableInfoAndValue
   {
      
      private var var_1108:WiredVariable;
      
      private var _value:int;
      
      public function VariableInfoAndValue(param1:IMessageDataWrapper)
      {
         super();
         var_1108 = new WiredVariable(param1);
         _value = param1.readInteger();
      }
      
      public function get variable() : WiredVariable
      {
         return var_1108;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}

