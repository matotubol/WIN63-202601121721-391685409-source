package com.sulake.habbo.moderation
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.parser.moderation.class_3291;
   
   public class IssueBundle
   {
      
      private var var_197:int;
      
      private var var_463:class_55;
      
      private var var_61:int;
      
      private var var_4242:int = 0;
      
      private var _pickerName:String = "";
      
      private var var_150:int;
      
      private var var_3729:int;
      
      private var var_1987:int = 0;
      
      private var var_3499:int = 0;
      
      private var var_1125:class_3291 = null;
      
      private var _highestPriorityIssue:class_3291 = null;
      
      public function IssueBundle(param1:int, param2:class_3291)
      {
         super();
         var_197 = param1;
         var_463 = new class_55();
         var_61 = param2.state;
         var_4242 = param2.pickerUserId;
         _pickerName = param2.pickerUserName;
         var_150 = param2.reportedUserId;
         var_3729 = param2.groupingId;
         addIssue(param2);
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get issues() : Array
      {
         return var_463.getValues();
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get pickerUserId() : int
      {
         return var_4242;
      }
      
      public function get pickerName() : String
      {
         return _pickerName;
      }
      
      public function matches(param1:class_3291, param2:Boolean = false) : Boolean
      {
         if(var_3729 == 0 || param1.groupingId == 0)
         {
            return false;
         }
         if(var_3729 != param1.groupingId || var_150 != param1.reportedUserId)
         {
            return false;
         }
         if(!param2)
         {
            if(state != param1.state)
            {
               return false;
            }
            if(pickerUserId != param1.pickerUserId)
            {
               return false;
            }
         }
         return true;
      }
      
      public function contains(param1:int) : Boolean
      {
         if(var_463 == null)
         {
            return false;
         }
         return var_463.getKeys().indexOf(param1) > -1;
      }
      
      public function updateIssue(param1:class_3291) : void
      {
         removeIssue(param1.issueId);
         addIssue(param1);
      }
      
      private function addIssue(param1:class_3291) : void
      {
         var_463.add(param1.issueId,param1);
         var_3499 = param1.issueAgeInMilliseconds;
         if(param1.message != null && param1.message != "")
         {
            var_1987 = var_1987 + 1;
         }
         if(var_1125 == null || param1.issueAgeInMilliseconds > var_1125.issueAgeInMilliseconds)
         {
            var_1125 = param1;
         }
         _highestPriorityIssue = null;
         getHighestPriorityIssue();
      }
      
      public function removeIssue(param1:int) : class_3291
      {
         var _loc2_:class_3291 = var_463.remove(param1) as class_3291;
         if(_loc2_ != null)
         {
            if(_loc2_.message != null && _loc2_.message != "")
            {
               var_1987 = var_1987 - 1;
            }
            if(var_1125 == _loc2_)
            {
               var_1125 = null;
            }
            if(_highestPriorityIssue == _loc2_)
            {
               _highestPriorityIssue = null;
            }
         }
         return _loc2_;
      }
      
      public function get highestPriority() : int
      {
         if(_highestPriorityIssue == null)
         {
            getHighestPriorityIssue();
         }
         if(_highestPriorityIssue != null)
         {
            return _highestPriorityIssue.priority;
         }
         return 0;
      }
      
      public function getHighestPriorityIssue() : class_3291
      {
         var _loc3_:class_3291 = null;
         var _loc4_:class_3291 = null;
         var _loc2_:int = 0;
         var _loc1_:class_3291 = null;
         var _loc5_:Boolean = false;
         if(_highestPriorityIssue == null)
         {
            if(var_463 == null || var_463.length < 1)
            {
               return null;
            }
            _loc2_ = 0;
            while(_loc2_ < var_463.length)
            {
               _loc1_ = var_463.getWithIndex(_loc2_);
               _loc5_ = _loc1_.reportedCategoryId > 0 && _loc1_.reportedCategoryId < 100;
               if(_loc5_)
               {
                  if(_loc4_ == null || _loc4_.priority > _loc1_.priority)
                  {
                     _loc4_ = _loc1_;
                  }
               }
               else if(_loc3_ == null || _loc3_.priority > _loc1_.priority)
               {
                  _loc3_ = _loc1_;
               }
               _loc2_++;
            }
            if(_loc4_ != null)
            {
               _highestPriorityIssue = _loc4_;
            }
            else
            {
               _highestPriorityIssue = _loc3_;
            }
         }
         return _highestPriorityIssue;
      }
      
      public function getIssueCount() : int
      {
         if(var_463 == null)
         {
            return 0;
         }
         return var_463.length;
      }
      
      public function getIssueIds() : Array
      {
         if(var_463 == null)
         {
            return [];
         }
         return var_463.getKeys();
      }
      
      public function get reportedUserId() : int
      {
         return var_150;
      }
      
      public function getMessageCount() : int
      {
         return var_1987;
      }
      
      public function get issueAgeInMilliseconds() : int
      {
         return var_3499;
      }
      
      public function getOpenTime(param1:int) : String
      {
         var _loc2_:* = null;
         var _loc3_:class_3291 = var_1125;
         if(_loc3_ == null)
         {
            for each(_loc2_ in var_463)
            {
               if(_loc3_ == null || _loc2_.issueAgeInMilliseconds > _loc3_.issueAgeInMilliseconds)
               {
                  _loc3_ = _loc2_;
               }
            }
            var_1125 = _loc3_;
         }
         if(_loc3_ != null)
         {
            return _loc3_.getOpenTime(param1);
         }
         return "";
      }
   }
}

