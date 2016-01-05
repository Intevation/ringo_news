#!/usr/bin/env python
# encoding: utf-8


def add_news_parser(subparsers, parent):
    p = subparsers.add_parser('news',
                              help='Management of the news extension',
                              parents=[parent])
    sp = p.add_subparsers(help='News command help')
    add_parser = sp.add_parser('add',
                               help=('Adds or Updates news items.'),
                               parents=[parent])
    add_parser.add_argument('jsonfile', help="JSON file with news")
    add_parser.set_defaults(func=handle_add_command)
    del_parser = sp.add_parser('del',
                               help=('Deletes a given news items.'),
                               parents=[parent])
    del_parser.add_argument('id', help="ID of the news item to be deleted")
    del_parser.set_defaults(func=handle_del_command)


def handle_add_command(args):
    print "Add"


def handle_del_command(args):
    print "Del"
