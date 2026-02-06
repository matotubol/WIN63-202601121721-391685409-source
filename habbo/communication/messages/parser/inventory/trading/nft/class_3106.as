package package_111
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2870;
   
   [SecureSWF(rename="true")]
   public class class_3106 extends class_2870
   {
      
      private var var_4911:Number;
      
      public function class_3106(param1:IMessageDataWrapper)
      {
         var_4911 = param1.readLong();
         super(param1);
      }
      
      public function get assetId() : Number
      {
         return var_4911;
      }
   }
}

