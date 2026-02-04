package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   
   public interface IIssueHandler extends class_13
   {
      
      function updateIssuesAndMessages() : void;
      
      function showDefaultSanction(param1:int, param2:String) : void;
   }
}

