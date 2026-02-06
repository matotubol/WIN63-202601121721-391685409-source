package package_139
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3417
   {
      
      public static var var_5180:int = 0;
      
      public static var var_3480:int = 1;
      
      public static var var_5228:int = 2;
      
      private var var_2725:Number;
      
      private var var_2499:String;
      
      private var var_4730:String;
      
      private var var_4654:Boolean;
      
      private var var_3851:String;
      
      private var var_4829:String;
      
      private var var_4846:int;
      
      private var var_2743:int;
      
      private var _status:int;
      
      private var var_3145:int;
      
      private var var_2926:Date = new Date();
      
      private var var_2584:Vector.<class_3743>;
      
      public function class_3417(param1:IMessageDataWrapper)
      {
         super();
         var_2725 = param1.readLong();
         var_2499 = param1.readString();
         var_4730 = param1.readString();
         var_4654 = param1.readBoolean();
         var_3851 = param1.readString();
         var_4829 = param1.readString();
         var_4846 = param1.readInteger();
         var_2743 = param1.readInteger();
         _status = param1.readByte();
         var_3145 = param1.readInteger();
         var_2584 = new Vector.<class_3743>();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_2584.push(new class_3743(param1));
            _loc2_ = 0 + 1;
         }
      }
      
      public function get taskId() : Number
      {
         return var_2725;
      }
      
      public function get taskCode() : String
      {
         return var_2499;
      }
      
      public function get questTypeCode() : String
      {
         return var_4730;
      }
      
      public function get isBonus() : Boolean
      {
         return var_4654;
      }
      
      public function get imageVersion() : String
      {
         return var_3851;
      }
      
      public function get catalogName() : String
      {
         return var_4829;
      }
      
      public function get requiredRepeats() : int
      {
         return var_4846;
      }
      
      public function get repeats() : int
      {
         return var_2743;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get secondsLeft() : int
      {
         if(var_3145 <= 0)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = (_loc1_.getTime() - var_2926.getTime()) / 1000;
         return var_3145 - _loc2_;
      }
      
      public function get isExpired() : Boolean
      {
         return var_3145 < 0 && _status != var_5180;
      }
      
      public function get rewards() : Vector.<class_3743>
      {
         return var_2584;
      }
      
      public function set repeats(param1:int) : void
      {
         var_2743 = param1;
      }
      
      public function set status(param1:int) : void
      {
         _status = param1;
      }
      
      public function get nameLocalizationKey() : String
      {
         return "dailytask." + var_2499 + ".name";
      }
      
      public function get descriptionLocalizationKey() : String
      {
         return "dailytask." + var_2499 + ".desc";
      }
      
      public function get hintLocalizationKey() : String
      {
         return "dailytask." + var_2499 + ".hint";
      }
   }
}

