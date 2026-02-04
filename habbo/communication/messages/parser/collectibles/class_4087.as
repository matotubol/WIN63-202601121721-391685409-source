package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4087
   {
      
      public static var var_5401:int = 0;
      
      public static var var_5390:int = 1;
      
      public static var var_5393:int = 2;
      
      public static var var_1633:int = 0;
      
      public static var var_5047:int = 1;
      
      private var _items:Array;
      
      private var var_3844:String;
      
      private var var_3968:String;
      
      private var var_4788:int;
      
      private var var_4327:int;
      
      private var var_4894:int;
      
      private var var_3698:class_4130;
      
      private var var_3649:class_4130;
      
      private var var_5133:Number;
      
      private var var_3524:Number;
      
      private var _status:int;
      
      private var var_1024:CollectibleItemClaim;
      
      private var var_937:CollectibleItemClaim;
      
      private var var_2583:int;
      
      private var var_1437:int = var_1633;
      
      private var var_1305:int = var_1633;
      
      public function class_4087(param1:IMessageDataWrapper)
      {
         super();
         var _loc6_:int = param1.readInteger();
         _items = [];
         var_2583 = 0;
         var _loc3_:int = 0;
         while(0 < _loc6_)
         {
            var _loc2_:class_4130 = new class_4130(param1);
            _items.push(null);
            if(null.amount > 0)
            {
               var_2583 += 1;
            }
            _loc3_++;
         }
         var_3844 = param1.readString();
         var_3968 = param1.readString();
         var_4788 = param1.readInteger();
         var_4327 = param1.readInteger();
         var_4894 = param1.readInteger();
         var _loc4_:Boolean = param1.readBoolean();
         if(_loc4_)
         {
            var_3698 = new class_4130(param1);
         }
         var _loc5_:Boolean = param1.readBoolean();
         if(_loc5_)
         {
            var_3649 = new class_4130(param1);
         }
         var_5133 = param1.readLong();
         var_3524 = param1.readLong();
         _status = param1.readShort();
         if(_loc4_)
         {
            var_1024 = new CollectibleItemClaim(param1);
         }
         if(_loc5_)
         {
            var_937 = new CollectibleItemClaim(param1);
         }
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      public function get collectionId() : String
      {
         return var_3844;
      }
      
      public function get collectionName() : String
      {
         return var_3968;
      }
      
      public function get collectionScore() : int
      {
         return var_4788;
      }
      
      public function get collectionTotalScore() : int
      {
         return var_4327;
      }
      
      public function get collectionBoostScore() : int
      {
         return var_4894;
      }
      
      public function get bonusItem() : class_4130
      {
         return var_3698;
      }
      
      public function get rewardItem() : class_4130
      {
         return var_3649;
      }
      
      public function get releasedTime() : Number
      {
         return var_5133;
      }
      
      public function get snapshotTime() : Number
      {
         return var_3524;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get bonusItemClaim() : CollectibleItemClaim
      {
         return var_1024;
      }
      
      public function get rewardItemClaim() : CollectibleItemClaim
      {
         return var_937;
      }
      
      public function get collectedItemCount() : int
      {
         return var_2583;
      }
      
      public function get totalItemCount() : int
      {
         return _items.length;
      }
      
      public function get progressPercentage() : int
      {
         return collectedItemCount * 100 / totalItemCount;
      }
      
      public function get claimingBonusStatus() : int
      {
         return var_1437;
      }
      
      public function get claimingRewardStatus() : int
      {
         return var_1305;
      }
      
      public function claimRewardAwaiting() : void
      {
         var_1305 = var_5047;
      }
      
      public function claimBonusAwaiting() : void
      {
         var_1437 = var_5047;
      }
      
      public function claimRewardFinished(param1:Boolean) : void
      {
         var_1305 = var_1633;
         if(param1)
         {
            rewardItemClaim.claimedAmount += 1;
         }
      }
      
      public function claimBonusFinished(param1:Boolean) : void
      {
         var_1437 = var_1633;
         if(param1)
         {
            bonusItemClaim.claimedAmount += 1;
         }
      }
      
      public function get hasRewardItem() : Boolean
      {
         return var_3649 != null;
      }
      
      public function get hasBonusItem() : Boolean
      {
         return var_3698 != null;
      }
      
      public function get rewardClaimed() : Boolean
      {
         return hasRewardItem && var_937 != null && (var_937.claimedAmount > 0 && var_937.claimedAmount >= var_937.claimLimit || var_1305 == class_4087.var_5047);
      }
      
      public function get bonusClaimed() : Boolean
      {
         return hasBonusItem && var_1024 != null && (var_1024.claimedAmount > 0 && var_1024.claimedAmount >= var_1024.claimLimit || var_1437 != class_4087.var_1633);
      }
      
      public function get canClaimReward() : Boolean
      {
         return hasRewardItem && var_937 != null && var_937.status == CollectibleItemClaim.var_5260 && !rewardClaimed && var_937.claimedAmount < var_937.claimLimit && var_1305 == class_4087.var_1633;
      }
      
      public function get canClaimBonus() : Boolean
      {
         return hasBonusItem && var_1024 != null && var_1024.status == CollectibleItemClaim.var_5260 && !bonusClaimed && var_1024.claimedAmount < var_1024.claimLimit && var_1437 == class_4087.var_1633;
      }
      
      public function isBonusSnapshotPassed() : Boolean
      {
         return var_3524 < new Date().time;
      }
   }
}

