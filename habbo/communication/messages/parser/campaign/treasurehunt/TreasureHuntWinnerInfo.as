package package_136
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class TreasureHuntWinnerInfo
   {
      
      private var var_2821:String;
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_4564:String;
      
      private var var_4448:String;
      
      public function TreasureHuntWinnerInfo(param1:IMessageDataWrapper)
      {
         super();
         var_2821 = param1.readString();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
         var_4564 = param1.readString();
         var_4448 = param1.readString();
      }
      
      public function get huntId() : String
      {
         return var_2821;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userFigure() : String
      {
         return var_4564;
      }
      
      public function get userGender() : String
      {
         return var_4448;
      }
   }
}

