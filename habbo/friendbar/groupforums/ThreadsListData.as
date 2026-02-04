package com.sulake.habbo.friendbar.groupforums
{
   import flash.utils.Dictionary;
   import package_155.class_3434;
   
   public class ThreadsListData
   {
      
      public static const PAGE_SIZE:int = 20;
      
      private var var_1744:int;
      
      private var var_369:int;
      
      private var var_3704:Array;
      
      private var var_3422:Dictionary;
      
      public function ThreadsListData(param1:int, param2:int, param3:Array)
      {
         super();
         var_1744 = param1;
         var_369 = param2;
         var_3704 = param3;
         var_3422 = new Dictionary();
         var _loc4_:int = 0;
         while(0 < param3.length)
         {
            var _loc5_:class_3434 = param3[0];
            var_3422[null.threadId] = null;
            _loc4_++;
         }
      }
      
      public function get totalThreads() : int
      {
         return var_1744;
      }
      
      public function get startIndex() : int
      {
         return var_369;
      }
      
      public function get threads() : Array
      {
         return var_3704;
      }
      
      public function get threadsById() : Dictionary
      {
         return var_3422;
      }
      
      public function get size() : int
      {
         return var_3704.length;
      }
      
      public function updateThread(param1:class_3434) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:class_3434 = null;
         threadsById[param1.threadId] = param1;
         _loc3_ = 0;
         while(_loc3_ < threads.length)
         {
            _loc2_ = threads[_loc3_];
            if(_loc2_.threadId == param1.threadId)
            {
               threads[_loc3_] = param1;
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}

