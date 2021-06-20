class Node(object):
    val=None
    left=None
    right=None
    parent=None


class MaxHeap(object):
    nodes = list()
    head = None
    p_ptr = 0
    h_map = dict()
    def insert(s, val):
        node = Node()
        node.val = val

        s.h_map[val] = node

        s.nodes.append(node)
        if not s.head:
            s.head = node
            return

        p_node = s.nodes[s.p_ptr]

        if not p_node.left:
            p_node.left = node
        else:
            p_node.right = node
            s.p_ptr += 1
        
        node.parent = p_node
        s._up_heap(node)

    def _up_heap(s, node):
        if not node.parent:
            return
        
        p_node = node.parent
        if node.val > p_node.val:
            node.val, node.parent.val = p_node.val, node.val
            s.h_map[node.val] = node
            s.h_map[p_node.val] = p_node
            s._up_heap(p_node)

    def top(s):
        return s.head.val

    def delete(s,  val):
        node = s.h_map[val]

        l_node = s.nodes.pop()

        node.val = l_node.val

        s.h_map[node.val] = node
        
        s._detach_node(l_node)
        s._down_heap(node)

        del s.h_map[val]

    def _detach_node(s, node):
        p_node = node.parent
        if p_node.left == node:
            p_node.left = None
        else:
            p_node.right = None
            s.p_ptr -= 1
        

    def _down_heap(s, node):
        if not node.left:
            return
        mc_node = node.left

        if node.right and node.right.val > mc_node.val:
            mc_node = node.right
        
        if mc_node.val > node.val:
            mc_node.val, node.val = node.val, mc_node.val
            s.h_map[node.val] = node
            s.h_map[mc_node.val] = mc_node
            s._down_heap(mc_node)


def test():
    mh = MaxHeap()
    mh.insert(6)
    mh.insert(2)
    mh.insert(3)
    mh.insert(1)
    mh.insert(5)
    mh.insert(4)

    mh.delete(6)

    print mh.top()

    mh.delete(5)

    print mh.top()

    mh.delete(4)

    print mh.top()

    mh.delete(3)

    print mh.top()

    print mh.top()

test()