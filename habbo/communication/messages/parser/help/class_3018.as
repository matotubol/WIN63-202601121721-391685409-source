package package_175
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3018
   {
      
      private var var_230:int;
      
      private var var_3952:int;
      
      private var var_4665:Boolean;
      
      private var var_1927:String;
      
      private var var_1840:String;
      
      private var var_735:String;
      
      private var _roomName:String;
      
      public function class_3018(param1:IMessageDataWrapper)
      {
         super();
         var_230 = param1.readInteger();
         var_3952 = param1.readInteger();
         var_4665 = param1.readBoolean();
         switch(var_230)
         {
            case 0:
            case 2:
               var_1927 = param1.readString();
               var_1840 = param1.readString();
               return;
            case 1:
               var_1927 = param1.readString();
               var_1840 = param1.readString();
               var_735 = param1.readString();
               return;
            case 3:
               if(!isGuide)
               {
                  var_1927 = param1.readString();
                  var_1840 = param1.readString();
                  _roomName = param1.readString();
               }
               return;
            default:
               return;
         }
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get secondsAgo() : int
      {
         return var_3952;
      }
      
      public function get isGuide() : Boolean
      {
         return var_4665;
      }
      
      public function get otherPartyName() : String
      {
         return var_1927;
      }
      
      public function get otherPartyFigure() : String
      {
         return var_1840;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
   }
}

