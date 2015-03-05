require "ruboty"
require "yaml"

module Ruboty
  module Handlers
    class Replace < Base
      BRAIN_NAMESPACE = "ruboty-replace"

      on(
        /list patterns/,
        description: "List registered patterns to replace",
        name: :list
      )

      on(
        %r<replace (?<pattern>.+?) with (?<template>.+)>m,
        description: "Register pattern to replace",
        name: :register,
      )

      on(
        //,
        all: true,
        description: "Replace message with registered patterns",
        hidden: true,
        name: :replace,
      )

      def list(message)
        message.reply(patterns_in_string, code: true)
      end

      def register(message)
        store[message[:pattern]] = message[:template]
        message.reply("Registered!")
      end

      def replace(message)
        puts "TODO"
      end

      private

      def patterns_in_string
        if store.empty?
          "No pattern registered"
        else
          store.to_yaml[4..-1]
        end
      end

      def store
        robot.brain.data[BRAIN_NAMESPACE] ||= {}
      end
    end
  end
end
