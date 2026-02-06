package package_38
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SnowballPileGameObjectData extends SnowWarGameObjectData
   {
      
      public static const const_31:int = 7;
      
      public function SnowballPileGameObjectData(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      override public function parse(param1:IMessageDataWrapper) : void
      {
         parseVariables(param1,7);
      }
      
      public function get locationX3D() : int
      {
         return getVariable(2);
      }
      
      public function get locationY3D() : int
      {
         return getVariable(3);
      }
      
      public function get maxSnowballs() : int
      {
         return getVariable(4);
      }
      
      public function get snowballCount() : int
      {
         return getVariable(5);
      }
      
      public function get fuseObjectId() : int
      {
         return getVariable(6);
      }
   }
}

