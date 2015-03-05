require "ruboty"
require "yaml"

module Ruboty
  module Handlers
    class Replace < Base
      BRAIN_NAMESPACE = "ruboty-replace"

      on(
        /delete pattern (?<pattern>.+)/m,
        description: "Delete pattern",
        name: "delete",
      )

      on(
        /list patterns/,
        description: "List registered patterns to replace",
        name: :list,
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

      def delete(message)
        if store.delete(message[:pattern])
          message.reply("Deleted")
        else
          message.reply("Not found")
        end
      end

      def list(message)
        message.reply(patterns_in_string, code: true)
      end

      def register(message)
        store[message[:pattern]] = message[:template]
        message.reply("Registered")
      end

      def replace(message)
        store.each do |pattern, template|
          begin
            message.body.gsub!(Regexp.new(pattern), template)
          rescue => e
            Ruboty.logger.debug("#{e.class}: #{e}")
          end
        end
      end

      private

      def patterns_in_string
        if store.empty?
          "No pattern registered"
        else
          store.map do |pattern, template|
            "#{pattern} -> #{template}"
          end.join("\n")
        end
      end

      def store
        robot.brain.data[BRAIN_NAMESPACE] ||= {}
      end
    end
  end
end
